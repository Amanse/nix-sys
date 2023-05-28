{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    #    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.jotaro = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./sys-config
      ];
    };
  };
}
