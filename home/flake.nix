{
  description = "Home configuration for ME";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    webcord.url = "github:fufexan/webcord-flake";

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    xdg-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
    };

    neovim-flake = {
      url = "github:notashelf/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun.url = "github:Kirottu/anyrun";

    game-rs = {
      url = "github:amanse/game-rs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    hyprland,
    neovim-flake,
    game-rs,
    anyrun,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      system = system;
      # overlays = [anyrun.overlay];
      allowUnfree = true;
    };
  in {
    homeConfigurations.me = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        neovim-flake.homeManagerModules.default
        hyprland.homeManagerModules.default
        anyrun.homeManagerModules.default
        ./default.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {inherit hyprland game-rs anyrun;};
    };
  };
}
