{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
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
      capSysNice = true;
    };

    hyprland = {
      enable = true;
    };

    auto-cpufreq.enable = true;
  };

  services.dbus.packages = with pkgs; [hyprland libsecret];

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
