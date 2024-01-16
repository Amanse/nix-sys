{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    #gui
    brave
    # google-chrome
    firefox-wayland
    # joplin
    cinnamon.nemo-with-extensions
    evince
    heroic
    spotify
    qbittorrent
    libreoffice-qt
    calibre
    openjdk17-bootstrap
    cinnamon.warpinator # File sharing app that works
    wdisplays #display managment
    # blackbox-terminal
    ripdrag

    android-file-transfer
    simple-mtpfs

    # thorium-browser

    #college
    # jetbrains.idea-community
    # firefox-devedition

    #cli
    megacmd
    spotify-player
    wl-clipboard
    # inputs.nix-gaming.packages.${pkgs.system}.wine-ge
    # wine-wayland

    #dev
    rustup
    nodejs
    nodePackages_latest.pnpm
    bun

    sbctl

    #games
    # airshipper
    inputs.game-rs.packages.x86_64-linux.default
  ];
}
