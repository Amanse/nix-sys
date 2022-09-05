{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.05";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.3.1";

  };

  outputs = inputs@{ self, nixpkgs, nixos-hardware, utils,... }:
    utils.lib.mkFlake {
      inherit self inputs;
      
      # Channel config
      channels.nixpkgs.input = nixpkgs;
      channelsConfig.allowUnfree = true;

      hosts.nixxy = {
        system = "x86_64-linux";
        channelName = "nixpkgs";
        modules = [
          ./boot.nix
          ./gnome.nix
          ./hardware-configuration.nix
          ./networking.nix
          ./nvidia.nix
          ./packages.nix
          ./sound.nix
          ./users.nix
          ./font.nix
	  ./sys.nix
        ];
      };
    };
}
