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

    #cli
    megacmd

    #dev
    rustup
    nodejs
  ];
}
