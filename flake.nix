{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #    hyprland.url = "github:hyprwm/Hyprland";
    xdg-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    xdg-portal-hyprland,
    ...
  } @ inputs: {
    nixosConfigurations.jotaro = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit xdg-portal-hyprland;};
      modules = [
        ./sys-config
        #        hyprland.nixosModules.default
        #       {
        #        programs.hyprland = {
        #         enable = true;
        #package = hyprland.packages."x86_64-linux".hyprland-nvidia;
        #      };
        # }
      ];
    };
  };
}
