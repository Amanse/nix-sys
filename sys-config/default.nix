{config,pkgs,...}:

{

  imports = [
    ./boot.nix
    ./gnome.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./nvidia.nix
    ./packages.nix
    ./sound.nix
    ./users.nix
    ./font.nix
		#./zsh.nix
		./intel.nix
		./keys.nix
];

	fileSystems."/mnt/stuff"={
		device="/dev/sda5";
		fsType="ntfs";
		options=["rw" "uid=me"];
	};

	fileSystems."/mnt/stuff2"={
		device="/dev/sda6";
		fsType="ntfs";
		options=["rw" "uid=me"];
	};


	nix.gc = {
		automatic=true;
		dates="weekly";
	};

	nix.settings.auto-optimise-store = true;

	nixpkgs.config = {
	    allowUnfree = true;
  	};

}
