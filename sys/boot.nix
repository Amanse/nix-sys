{
  lib,
  config,
  pkgs,
  ...
}: {
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  # boot.loader.grub = {
  #   efiSupport = true;
  #   device = "nodev";
  # };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  system.stateVersion = "22.11";

  boot.plymouth.enable = true;
}
