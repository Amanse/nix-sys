{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    nixos-hardware,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit self inputs;};
      modules = with nixos-hardware.nixosModules; [
        lanzaboote.nixosModules.lanzaboote
        ./system
        common-pc-laptop
        common-pc-laptop-acpi_call
        common-pc-laptop-hdd
      ];
    };
  };
}
