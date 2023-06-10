{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.jotaro = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./sys
      ];
    };
  };
}
