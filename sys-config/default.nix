{ config, pkgs, ... }:

{

  imports = [
    ./boot.nix
    ./gui.nix
    ./graphics.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./packages.nix
    ./sound.nix
    ./users.nix
    ./font.nix
    ./keys.nix
  ];

  fileSystems."/mnt/stuff" = {
    device = "/dev/sda6";
    fsType = "ntfs";
    options = [ "rw" "uid=me" "noatime" ];
  };

  fileSystems."/mnt/stuff2" = {
    device = "/dev/sda7";
    fsType = "ntfs";
    options = [ "rw" "uid=me" "noatime" ];
  };


  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  nix.settings.auto-optimise-store = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
