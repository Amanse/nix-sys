# https://modrinth.com/app
{
  pkgs,
  lib,
  stdenv,
  fetchurl,
  ...
}: let
  inherit
    (lib)
    optional
    optionals
    makeLibraryPath
    makeSearchPathOutput
    makeBinPath
    optionalString
    strings
    escapeShellArg
    ;

  deps = with pkgs.xorg;
  with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libdrm
    libX11
    libGL
    libxkbcommon
    libXScrnSaver
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libxshmfence
    libXtst
    libuuid
    mesa
    nspr
    nss
    pango
    pipewire
    udev
    wayland
    xorg.libxcb
    zlib
    snappy
    libkrb5
    libpulseaudio
    libva
  ];

  rpath = makeLibraryPath deps + ":" + makeSearchPathOutput "lib" "lib64" deps;
  binpath = makeBinPath deps;

  enableFeatures = ["VaapiVideoDecoder" "VaapiVideoEncoder" "Vulkan"];

  # The feature disable is needed for VAAPI to work correctly: https://github.com/brave/brave-browser/issues/20935
  disableFeatures = ["UseChromeOSDirectVideoDecoder"];
in
  stdenv.mkDerivation rec {
    pname = "thorium";
    version = "117.0.5938.157";

    src = fetchurl {
      url = "https://github.com/Alex313031/Thorium/releases/download/M${version}/thorium-browser_${version}_amd64.deb";
      sha256 = "sha256-muNBYP6832PmP0et9ESaRpd/BIwYZmwdkHhsMNBLQE4=";
    };

    dontConfigure = true;
    dontBuild = true;
    dontPatchELF = true;
    doInstallCheck = true;

    nativeBuildInputs = with pkgs; [
      dpkg
      (wrapGAppsHook.override {inherit makeWrapper;})
    ];

    buildInputs = with pkgs; [
      # needed for GSETTINGS_SCHEMAS_PATH
      glib
      gsettings-desktop-schemas
      gtk3

      # needed for XDG_ICON_DIRS
      gnome.adwaita-icon-theme
    ];

    unpackPhase = "dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner";

    installPhase = ''
      runHook preInstall

      mkdir -p $out $out/bin

      cp -R usr/share $out
      cp -R opt/ $out/opt

      export BINARYWRAPPER=$out/opt/chromium.org/thorium/thorium-browser

      # Fix path to bash in $BINARYWRAPPER
      substituteInPlace $BINARYWRAPPER \
          --replace /bin/bash ${stdenv.shell}

      ln -sf $BINARYWRAPPER $out/bin/thorium

      for exe in $out/opt/chromium.org/thorium/{thorium,chrome_crashpad_handler}; do
          patchelf \
              --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
              --set-rpath "${rpath}" $exe
      done

      # Fix paths
      substituteInPlace $out/share/applications/thorium-browser.desktop \
          --replace /usr/bin/thorium-browser $out/bin/thorium
      substituteInPlace $out/share/gnome-control-center/default-apps/thorium-browser.xml \
          --replace /opt/chromium.org $out/opt/chromium.org
      substituteInPlace $out/share/menu/thorium-browser.menu \
          --replace /opt/chromium.org $out/opt/chromium.org
      substituteInPlace $out/opt/chromium.org/thorium/default-app-block \
          --replace /opt/chromium.org $out/opt/chromium.org

      # Correct icons location
      icon_sizes=("16" "24" "32" "48" "64" "128" "256")

      for icon in ''${icon_sizes[*]}
      do
          mkdir -p $out/share/icons/hicolor/$icon\x$icon/apps
          ln -s $out/opt/chromium.org/thorium/product_logo_$icon.png $out/share/icons/hicolor/$icon\x$icon/apps/thorium-browser.png
      done

      # Replace xdg-settings and xdg-mime
      ln -sf ${pkgs.xdg-utils}/bin/xdg-settings $out/opt/chromium.org/thorium/xdg-settings
      ln -sf ${pkgs.xdg-utils}/bin/xdg-mime $out/opt/chromium.org/thorium/xdg-mime

      runHook postInstall
    '';

    preFixup = ''
      # Add command line args to wrapGApp.
      gappsWrapperArgs+=(
        --prefix LD_LIBRARY_PATH : ${rpath}
        --prefix PATH : ${binpath}
        --suffix PATH : ${lib.makeBinPath [pkgs.xdg-utils pkgs.coreutils]}
        ${optionalString (enableFeatures != []) ''
        --add-flags "--enable-features=${strings.concatStringsSep "," enableFeatures}"
      ''}
        ${optionalString (disableFeatures != []) ''
        --add-flags "--disable-features=${strings.concatStringsSep "," disableFeatures}"
      ''}
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
        ${optionalString true ''
        --prefix XDG_DATA_DIRS  : "${pkgs.addOpenGLRunpath.driverLink}/share"
      ''}
        --add-flags ${escapeShellArg ""}
      )
    '';

    installCheckPhase = ''
      # Bypass upstream wrapper which suppresses errors
      $out/opt/chromium.org/thorium/thorium-browser --version
    '';

    meta = with lib; {
      homepage = "https://brave.com/";
      description = "Privacy-oriented browser for Desktop and Laptop computers";
      changelog = "https://github.com/brave/brave-browser/blob/master/CHANGELOG_DESKTOP.md#" + replaceStrings ["."] [""] version;
      longDescription = ''
        Brave browser blocks the ads and trackers that slow you down,
        chew up your bandwidth, and invade your privacy. Brave lets you
        contribute to your favorite creators automatically.
      '';
      sourceProvenance = with sourceTypes; [binaryNativeCode];
      license = licenses.mpl20;
      maintainers = with maintainers; [uskudnik rht jefflabonte nasirhm];
      platforms = ["x86_64-linux"];
    };
  }
