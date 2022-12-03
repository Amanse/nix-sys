{ config, pkgs, unstable,... }:

{
  nix = {
    extraOptions = ''
        experimental-features = nix-command flakes
    	keep-outputs = true
   	keep-derivations = true
    '';
  };


  environment.systemPackages = with pkgs; [
    vim
    neovim
    htop
    git
    mpv
    yt-dlp

    brave
    google-chrome
    #obsidian
    lutris
    direnv
    nix-direnv
    lokinet
  ];


  programs.kdeconnect = {
    package = pkgs.gnomeExtensions.gsconnect;
    enable = true;
  };
  programs.adb.enable=true;
  services.flatpak.enable=true;

  xdg = {
    portal = {
      enable = true;
    };
  };

  environment.sessionVariables = {
     MOZ_ENABLE_WAYLAND = "1";
  };

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

}
