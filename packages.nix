{ config, pkgs, ... }:

{
  nix = {
    extraOptions = ''
        experimental-features = nix-command flakes
    '';
  };


  environment.systemPackages = with pkgs; [
    vim
    neovim
    htop
    git
    mpv
    tmux
    yt-dlp
    firefox
  ];


  programs.zsh.enable=true;
  programs.kdeconnect = {
    package = pkgs.gnomeExtensions.gsconnect;
    enable = true;
  };
  programs.adb.enable=true;
  services.flatpak.enable=true;
  xdg.portal.enable=true;

}
