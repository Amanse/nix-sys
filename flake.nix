{

  nixConfig = {
    extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    extra-trusted-substituters = ["https://nix-community.cachix.org" "https://hyprland.cachix.org"];

  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs = { self, nixpkgs, hyprland,... } @ inputs: {
    nixosConfigurations.nixxy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        hyprland.nixosModules.default
        { programs.hyprland = {
	     enable=true;
	  }; 
	}
        ./sys-config
      ];
    };
  };
}
