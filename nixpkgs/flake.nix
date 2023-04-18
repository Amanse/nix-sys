{
  description = "Home configuration for ME";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #spicetify-nix.url = "github:the-argus/spicetify-nix";
    webcord.url = "github:fufexan/webcord-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    # neovim-flake = {
    #   url = github:notashelf/neovim-flake;
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

  };

  outputs = { nixpkgs, home-manager, webcord, hyprland, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations.me = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home
          hyprland.homeManagerModules.default
        ];

        extraSpecialArgs = { inherit hyprland; };

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
