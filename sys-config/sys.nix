{config, pkgs, ...}:

{
	fileSystems."/mnt/stuff"={
		device="/dev/sda5";
		fsType="ntfs";
		options=["rw" "uid=me" "noatime"];
	};

	fileSystems."/mnt/stuff2"={
		device="/dev/sda6";
		fsType="ntfs";
		options=["rw" "uid=me" "noatime"];
	};


	nix.gc = {
		automatic=true;
		dates="weekly";
	};

	nix.settings.auto-optimise-store = true;

	system.autoUpgrade.enable = true;

	nixpkgs.config = {
    		allowUnfree = true;
  	};
	
}
