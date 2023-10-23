{
  description = "Home Manager configuration of me";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    game-rs.url = "github:amanse/game-rs";

    neovim-flake = {
      url = "github:notashelf/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    # hyprland.url = "github:hyprwm/Hyprland";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system}.extend (self: super: {thorium-browser = super.callPackage ./custom-pkgs/thorium {};});
  in {
    homeConfigurations."me" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./default.nix];
      extraSpecialArgs = {inherit inputs;};

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
