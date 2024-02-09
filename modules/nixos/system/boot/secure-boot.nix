{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myModules.boot.secure-boot;
  inherit (lib) mkIf mkEnableOption;
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];

  options.myModules.boot.secure-boot.enable = mkEnableOption "Enable the secure boot tooling";

  config = mkIf cfg.enable {
    environment.systemPackages = [
      # For debugging and troubleshooting Secure Boot.
      pkgs.sbctl
    ];
    # Bootloader.
    boot.loader.systemd-boot.enable = lib.mkForce false;
    # boot.loader.systemd-boot.enable = true;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}
