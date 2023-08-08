{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    #gui
    brave
    google-chrome
    obsidian
    heroic
    spotify
    qbittorrent
    libreoffice-qt
    jetbrains.idea-community
    openjdk17-bootstrap

    #cli
    megacmd
    spotify-player

    #dev
    rustup
    nodejs

    #games
    airshipper
    inputs.game-rs.packages.x86_64-linux.default

    #cli
    wl-clipboard
  ];
}
