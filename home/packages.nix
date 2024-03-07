{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    #gui
    # brave
    logseq
    iotas
    #    workflowy
    #    workflowy-desktop
    # google-chrome
    # firefox-wayland
    floorp
    # joplin
    cinnamon.nemo-with-extensions
    evince
    heroic
    spotify
    qbittorrent
    libreoffice-qt
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
    # megacmd
    # spotify-player
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
    pcsx2
    pcsx2-desktop
  ];
}
