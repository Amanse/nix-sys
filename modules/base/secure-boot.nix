{
  config,
  lib,
  ...
}: let
  cfg = config.systemModules.secureBoot;
in {
  options.systemModules.secureBoot = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}
