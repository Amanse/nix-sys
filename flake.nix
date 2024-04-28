{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    auto-cpufreq = {
      url = "github:adnanhodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland.url = "github:hyprwm/Hyprland";
    impermanence.url = "github:nix-community/impermanence";
    sddm-catppuccin.url = "github:khaneliman/sddm-catppuccin";
    sddm-catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    neovim-flake = {
      url = "github:notashelf/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    game-rs.url = "github:amanse/game-rs/umu";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    nixos-hardware,
    auto-cpufreq,
    home-manager,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      overlays = [(import ./home/custom-pkgs/pcsx2.nix) (import ./home/custom-pkgs/nvim/harpoon.nix) (import ./home/custom-pkgs/cemu.nix)];
    };
    # pkgs = pk.extend (import ./home/custom-pkgs/nvim/harpoon.nix);
  in {
    inherit pkgs;
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
        home-manager.nixosModules.home-manager
        ./system
        ./modules/nixos
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.me = import ./home;

            backupFileExtension = ".hm.bak";

            extraSpecialArgs = {
              inherit inputs pkgs;
            };
          };
        }
        # common-pc-laptop
        common-pc-laptop-acpi_call
        common-pc-laptop-ssd
      ];
    };
  };
}
