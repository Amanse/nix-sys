{ pkgs, config, ... }:

{
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
    };

    services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        layout = "us";
    };

    environment.gnome.excludePackages = (with pkgs.gnome; [
        gnome-software
	geary
	totem
	gnome-music
	epiphany
    ]);
}
