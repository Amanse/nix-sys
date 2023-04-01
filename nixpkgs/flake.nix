{
  description = "Home configuration for ME";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = { nixpkgs, home-manager, spicetify-nix, ... }:
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
          spicetify-nix.homeManagerModule
          {
            programs.spicetify = {
              enable = true;
              enabledExtensions = with  spicetify-nix.packages.${pkgs.system}.default.extensions; [shuffle fullAppDisplay popupLyrics playNext];
              enabledCustomApps = with spicetify-nix.packages.${pkgs.system}.default.apps; [lyrics-plus];
              theme = spicetify-nix.packages.${pkgs.system}.default.themes.catppuccin-mocha;
            };
          }
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
