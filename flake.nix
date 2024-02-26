{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    auto-cpufreq = {
      url = "github:adnanhodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    impermanence.url = "github:nix-community/impermanence";
    sddm-catppuccin.url = "github:khaneliman/sddm-catppuccin";
    sddm-catppuccin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    nixos-hardware,
    auto-cpufreq,
    ...
  } @ inputs: {
    # Move to flake parts if this becomes too big idk
    templates = {
      rust = {
        path = ./templates/rust; # Rust
        description = "Development environment for Rust";
      };

      go = {
        path = ./templates/go; # golang
        description = "Development environment for Golang";
      };
    };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit self inputs;};
      modules = with nixos-hardware.nixosModules; [
        auto-cpufreq.nixosModules.default
        ./system
        ./modules/nixos
        # common-pc-laptop
        common-pc-laptop-acpi_call
        common-pc-laptop-ssd
      ];
    };
  };
}
