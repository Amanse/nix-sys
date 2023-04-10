{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, hyprland, ... } @ inputs: {
    nixosConfigurations.nixxy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./sys-config
        hyprland.nixosModules.default
        {
          programs.hyprland = {
            enable = true;
          };
        }
      ];
    };
  };
}
