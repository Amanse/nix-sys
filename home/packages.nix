{pkgs, ...}: {
  home.packages = with pkgs; [
    #gui
    brave
    google-chrome
    obsidian
    megacmd
    airshipper
    heroic
    spotify
    qbittorrent
    libreoffice-qt
    jetbrains.idea-community
    openjdk17-bootstrap

    #cli
    megacmd

    #dev
    rustup
    nodejs
  ];
}
