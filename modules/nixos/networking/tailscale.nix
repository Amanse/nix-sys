{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.myModules.networking.tailscale;

  if-then-else = contd1: contd2: firstTrue: secondTrue: bothTrue: neither: (
    if contd1 && contd2
    then bothTrue
    else if contd1
    then firstTrue
    else if contd2
    then secondTrue
    else neither
  );
in {
  options.myModules.networking.tailscale = {
    enable = mkEnableOption "Enable all tailscale settings";
    isServer = mkEnableOption "use server routing features";
    isClient = mkEnableOption "use client routing features";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = with cfg; if-then-else isServer isClient "server" "client" "both" "none";
    };
  };
}
