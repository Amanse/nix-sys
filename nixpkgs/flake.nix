{
  description = "Home configuration for ME";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #spicetify-nix.url = "github:the-argus/spicetify-nix";
    webcord.url = "github:fufexan/webcord-flake";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdg-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #xdg-portal-hyprland.url = "github:hyprwm/xdg-portal-hyprland";
    neovim-flake = {
      url = "github:notashelf/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    game-rs = {
      url = "github:amanse/game-rs";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # anyrun.url = "github:Kirottu/anyrun";
    # anyrun.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    hyprland,
    neovim-flake,
    game-rs,
    # anyrun,
    ...
  }: let
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
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
        ./home
        neovim-flake.homeManagerModules.default
        hyprland.homeManagerModules.default
      ];

      extraSpecialArgs = {inherit hyprland game-rs;};

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
