{ osConfig, config, pkgs, lib,... }:
let
bemoji = pkgs.callPackage ./bemoji.nix { };
in
{
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

    brave
    google-chrome
    onedrive
    #spotify
    heroic
    #lutris
    sioyek
    logseq
    obsidian
    minecraft
    zoom-us
    onlyoffice-bin
    #nur.repos.iagocq.ultimmc

    #Window manager
    bemoji
    bemenu
    wayshot
    slurp
    grim
    wl-clipboard
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

}
