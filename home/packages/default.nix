{
  pkgs,
  game-rs,
  ...
}: let
  bemoji = pkgs.callPackage ./bemoji.nix {};
in {
  #imports = [./font.nix];
  home.packages = with pkgs; [
    zip
    unzip
    unrar
    p7zip
    gcc
    ripgrep
    bat
    #du-dust
    xdg-utils
    #xfce.thunar
    #tree-sitter
    #lokinet
    transmission
    #burpsuite
    playerctl
    megacmd
    #yarn
    rclone
    # gocryptfs
    gamemode
    gamescope
    mangohud
    openjdk
    rustup
    nodejs
    python310
    python310Packages.bootstrapped-pip
    protonvpn-cli

    brave
    microsoft-edge
    google-chrome
    #firefox-wayland
    #onedrive
    #spotify
    spotifywm
    #spot
    heroic
    #legendary-gl
    #lutris

    # sioyek
    # logseq
    obsidian
    #minecraft
    # zoom-us
    onlyoffice-bin
    webcord
    jetbrains.idea-community
    # Used to automatically mount devices
    #udiskie
    #yuzu-early-access
    #cemu
    #nur.repos.iagocq.ultimmc

    # jadx
    # apktool
    # apksigner

    #Window manager
    # bemoji
    wlsunset
    # bemenu
    batsignal
    wayshot
    slurp
    grim
    wl-clipboard

    #games
    airshipper
    game-rs.packages.x86_64-linux.default
  ];

  #programs.vscode = {
  #  enable = true;
  #  package = pkgs.vscode.fhs;
  #  };
}
