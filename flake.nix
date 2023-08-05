{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-23.05;

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    game-rs.url = "github:amanse/game-rs";

    neovim-flake = {
      url = "github:notashelf/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    game-rs,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit self inputs home-manager;};
      modules = [home-manager.nixosModules.home-manager ./system ./home];
    };
  };
}
