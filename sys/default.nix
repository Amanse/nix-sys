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
    ./login.nix
  ];

  # Increase max map count to the default value of steam deck
  boot.kernel.sysctl = {
    "vm.swappiness" = 5;
    "vm.max_map_count" = 2147483642;
  };

  # systemd.extraConfig = ''
  #   DefaultTimeoutStopSec=10s
  # '';

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
      "game-rs.cachix.org-1:fsu+ijfA2GCUE2QX0af80D7x9PCZS79EZbqwtOtlIhA="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      # "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];

    substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://webcord.cachix.org"
      "https://nixpkgs-unfree.cachix.org" # unfree-package cache
      "https://nixpkgs-wayland.cachix.org" # automated builds of *some* wayland packages
      "https://game-rs.cachix.org"
      "https://anyrun.cachix.org"
      # "https://nix-gaming.cachix.org"
    ];
    trusted-users = ["me" "@wheel"];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.journald.extraConfig = "SystemMaxUse=50M";
}
