{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote";

      # Optional but recommended to limit the size of your system closure.
      # inputs.nixpkgs.follows = "nixpkgs";
    };
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
        #inputs.lanzaboote.nixosModules.lanzaboote
      ];
    };
  };
}
