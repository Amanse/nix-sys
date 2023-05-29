{
  osConfig,
  config,
  pkgs,
  lib,
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
    xdg-utils
    xfce.thunar
    tree-sitter
    lokinet
    transmission
    #burpsuite
    playerctl
    megacmd
    yarn
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

    brave
    google-chrome
    firefox-wayland
    onedrive
    spotify
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
    udiskie
    yuzu-mainline
    cemu
    #nur.repos.iagocq.ultimmc

    jadx
    apktool

    #Window manager
    bemoji
    bemenu
    wayshot
    slurp
    grim
    wl-clipboard
    # anyrun
  ];

  #programs.vscode = {
  #  enable = true;
  #  package = pkgs.vscode.fhs;
  #  };
}
