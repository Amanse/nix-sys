{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs,... } @ inputs: {
    nixosConfigurations.nixxy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      #specialArgs = {inherit hyprland;};
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
