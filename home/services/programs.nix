{ config
, lib
, pkgs
, self
, ...
}:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.mpv = {
    enable = true;
    config = {
      force-window = true;
    };
  };

  programs.yt-dlp.enable = true;

  services.syncthing.enable = true;

  programs.mako = {
    enable = true;
    defaultTimeout = 5000;
  };

  services.playerctld = {
    enable = true;
    package = pkgs.playerctl;
  };

  #Play pause support from bluetooth earphones
  services.mpris-proxy.enable = true;

}
