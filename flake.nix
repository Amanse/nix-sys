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
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
  };
  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    nixos-hardware,
    auto-cpufreq,
    ...
  } @ inputs: {
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
