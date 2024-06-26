{
  lib,
  pkgs,
  self,
  inputs,
  config,
  ...
}:
with lib; {
  environment = {
    etc = {
      # set channels (backwards compatibility)
      # To use the same source in both home and system
      "nix/flake-channels/system".source = self;
      "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
      # "nix/flake-channels/hyprland".source = inputs.hyprland;
      #"nix/flake-channels/home-manager".source = home-manager;

      # preserve current flake in /etc
      "nixos/flake".source = self;
    };

    # we need git for flakes, don't we
    systemPackages = [pkgs.git];
  };
  # faster rebuilding
  documentation = {
    doc.enable = false;
    nixos.enable = false;
    info.enable = false;
    man = {
      enable = lib.mkDefault true;
      #generateCaches = lib.mkDefault true;
    };
  };
  nix = let
    mappedRegistry = mapAttrs (_: v: {flake = v;}) inputs;
  in {
    # pin the registry to avoid downloading and evaluating a new nixpkgs
    # version everytime
    # this will add each flake input as a registry
    # to make nix3 commands consistent with your flake
    registry = mappedRegistry // {default = mappedRegistry.nixpkgs;};

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    optimise = {
      automatic = true;
    };

    settings = {
      flake-registry = "/etc/nix/registry.json";
      auto-optimise-store = true;
      sandbox = true;
      keep-going = true;
      log-lines = 30;
      extra-experimental-features = [
        "flakes"
        "nix-command"
      ];
      warn-dirty = false;

      http-connections = 50;

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      builders-use-substitutes = true;

      substituters = [
        "https://cache.nixos.org" # funny binary cache
        "https://nix-community.cachix.org" # nix-community cache
        "https://hyprland.cachix.org" # hyprland
        "https://nix-gaming.cachix.org" # nix-gaming
        "https://nixpkgs-unfree.cachix.org" # unfree-package cache
        "https://numtide.cachix.org" # another unfree package cache
        # "https://cache.garnix.io" # minecraft
        "https://game-rs.cachix.org"
        "https://cosmic.cachix.org/"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        "game-rs.cachix.org-1:fsu+ijfA2GCUE2QX0af80D7x9PCZS79EZbqwtOtlIhA="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
    };
  };
}
