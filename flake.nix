{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    webcord.url = "github:fufexan/webcord-flake";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    xdg-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-flake = {
      url = "github:notashelf/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    game-rs = {
      url = "github:amanse/game-rs";
    };

    anyrun.url = "github:Kirottu/anyrun";
  };

  outputs = {
    self,
    nixpkgs,
    hyprland,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      system = system;
      overlays = [inputs.anyrun.overlay];
      allowUnfree = true;
    };
  in {
    nixosConfigurations.jotaro = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./sys
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.me = import ./home;
          home-manager.extraSpecialArgs = {inherit inputs hyprland;};

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
