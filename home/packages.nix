{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    #gui
    brave
    google-chrome
    # firefox-wayland
    obsidian
    xfce.thunar
    heroic
    spotify
    qbittorrent
    libreoffice-qt
    calibre
    openjdk17-bootstrap
    blackbox-terminal

    android-file-transfer

    #college
    jetbrains.idea-community
    firefox-devedition

    #cli
    megacmd
    spotify-player
    wl-clipboard
    inputs.nix-gaming.packages.${pkgs.system}.wine-ge

    #dev
    rustup
    nodejs

    #games
    airshipper
    inputs.game-rs.packages.x86_64-linux.default
  ];
}
