{

  nixConfig = {
    extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    extra-trusted-substituters = ["https://nix-community.cachix.org"];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
  };

  outputs = { self, nixpkgs,... } @ inputs: {
    nixosConfigurations.nixxy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./sys-config
      ];
    };
  };
}
