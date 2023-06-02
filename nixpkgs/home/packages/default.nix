{
  osConfig,
  config,
  pkgs,
  lib,
  game-rs,
  ...
}: let
  bemoji = pkgs.callPackage ./bemoji.nix {};
in {
  imports = [./font.nix];
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
    #megacmd
    #yarn
    rclone
    gocryptfs
    tailscale
    gamemode
    gamescope
    openjdk
    rustup
    nodejs
    python310
    python310Packages.bootstrapped-pip

    wine-wayland

    brave
    google-chrome
    #firefox-wayland
    #onedrive
    spotify
    #spot
    heroic
    #lutris
    sioyek
    logseq
    obsidian
    minecraft
    zoom-us
    onlyoffice-bin
    webcord
    jetbrains.idea-community
    # Used to automatically mount devices
    #udiskie
    #yuzu-early-access
    #cemu
    #nur.repos.iagocq.ultimmc

    jadx
    apktool
    apksigner

    #Window manager
    bemoji
    bemenu
    wayshot
    slurp
    grim
    wl-clipboard
    game-rs.packages.x86_64-linux.default
    # anyrun
  ];

  #programs.vscode = {
  #  enable = true;
  #  package = pkgs.vscode.fhs;
  #  };
}
