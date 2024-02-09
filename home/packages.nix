{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    #gui
    brave
#    workflowy
#    workflowy-desktop
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

    element-desktop-wayland

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

    #games
    wineWowPackages.full
    # airshipper
    # inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
    inputs.game-rs.packages.x86_64-linux.default
  ];
}
