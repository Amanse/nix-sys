{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      wine = prev.wine.override {waylandSupport = true;};
      steam = prev.steam.override ({extraPkgs ? pkgs': [], ...}: {
        extraPkgs = pkgs':
          (extraPkgs pkgs')
          ++ (with pkgs'; [
            libgdiplus
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
          ]);
      });
    })
  ];

  programs = {
    adb.enable = true;

    kdeconnect = {
      package = pkgs.libsForQt5.kdeconnect-kde;
      enable = true;
    };

    light.enable = true;

    steam = {
      enable = true;
      gamescopeSession.enable = true; #steamos like big picture mode session
    };

    gamemode = {
      enable = true;
      settings = {
        gpu = {
          gpu_device = 1;
        };
      };
    };

    gamescope = {
      enable = true;
      # capSysNice = true;
    };

    # hyprland = {
    #   enable = true;
    #   portalPackage = inputs
    # };

    auto-cpufreq.enable = true;
  };

  services.dbus.packages = with pkgs; [hyprland libsecret];

  disabledModules = ["programs/hyprland.nix"];

  services.xserver.displayManager.sessionPackages = [inputs.hyprland.packages.${pkgs.system}.default];

  xdg.portal = {
    enable = true;
    extraPortals = [
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    #neovim
    htop
    wget
    acpi
    gnome.gnome-tweaks
    # seatd # service enabled already

    #hyprland
    # hyprland-share-picker
  ];
}
