{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote";
  };
  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit self inputs;};
      modules = [lanzaboote.nixosModules.lanzaboote ./system];
    };
  };
}
