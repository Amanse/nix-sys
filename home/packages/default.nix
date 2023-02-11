{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    vim
    neovim
    htop
    mpv
    git
    yt-dlp

    zip
    unzip

    gcc
    ripgrep

    rustup
    rust-analyzer
    tmux
		
    brave
    google-chrome
    lutris
    heroic
    lokinet
  ];

}
