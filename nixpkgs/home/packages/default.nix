{
  osConfig,
  config,
  pkgs,
  lib,
  inputs,
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

    brave
    google-chrome
    #firefox-wayland
    #onedrive
    # spotify
    spotifywm
    #spot
    heroic
    legendary-gl
    lutris

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
    inputs.game-rs.packages.x86_64-linux.default
  ];

  #programs.vscode = {
  #  enable = true;
  #  package = pkgs.vscode.fhs;
  #  };
}
