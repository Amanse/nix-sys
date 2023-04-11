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

  nix.settings = {
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    substituters = [  "https://nix-community.cachix.org" "https://hyprland.cachix.org" ];
    trusted-users = ["me" "@wheel"];
  };


  environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
