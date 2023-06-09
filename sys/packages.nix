{
  config,
  pkgs,
  unstable,
  ...
}: {
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    htop
    #mpv
    #git
    #yt-dlp
    wget

    #brave
    #google-chrome
    #lutris
    #direnv
    #nix-direnv
    #lokinet
    #transmission
    #heroic
    #logseq

    gcc
    ripgrep

    #tmux
    #hypr
    #alacritty
    #rofi-wayland
    #bemenu
    #wl-clipboard
    acpi #battery
    #mako
    pulseaudio
    #grim
    #playerctl
    wlogout
    hyprpaper
    pavucontrol
    #xdg-desktop-portal-hyprland
    qt6.qtwayland
    hyprland-share-picker
    gnome.gnome-tweaks
  ];

  programs.light.enable = true;
  programs.kdeconnect = {
    enable = true;
  };
  programs.adb.enable = true;
  #services.flatpak.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # For steam to use proton-ge and other stuff
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
    # Steam needs this to find Proton-GE
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    # note: this doesn't replace PATH, it just adds this to it
    PATH = [
      "\${XDG_BIN_HOME}"
    ];
  };

  # Window manager firefox
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  services.aria2 = {
    enable = true;
    extraArguments = "--rpc-listen-all --remote-time=true";
    openPorts = true;
    downloadDir = "/mnt/stuff/Downloads";
  };
}