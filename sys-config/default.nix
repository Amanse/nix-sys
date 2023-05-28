{
  config,
  pkgs,
  ...
}: {
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
    fsType = "btrfs";
    options = ["rw" "noatime"];
  };

  fileSystems."/mnt/stuff2" = {
    device = "/dev/sda7";
    fsType = "btrfs";
    options = ["rw" "noatime"];
  };

  # Increase max map count to the default value of steam deck
  boot.kernel.sysctl = {
    "vm.swappiness" = 5;
    "vm.max_map_count" = 2147483642;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  nix.settings.auto-optimise-store = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  #fix headphone+mic
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=dell-headset-multi
  '';

  nix.settings = {
    keep-derivations = true;
    keep-outputs = true;

    builders-use-substitutes = true;

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "webcord.cachix.org-1:l555jqOZGHd2C9+vS8ccdh8FhqnGe8L78QrHNn+EFEs="
      "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];

    substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://webcord.cachix.org"
      "https://nixpkgs-unfree.cachix.org" # unfree-package cache
      "https://nixpkgs-wayland.cachix.org" # automated builds of *some* wayland packages
    ];
    trusted-users = ["me" "@wheel"];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
