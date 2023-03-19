{ pkgs, config, ... }:
{
    environment.pathsToLink = ["/libexec"];
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
    };

    services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
	desktopManager.xterm.enable = true;
	libinput.enable = true;
	libinput.touchpad.naturalScrolling=true;
	windowManager.i3 = {
          enable = true;
	};
        layout = "us";
    };

    programs.sway = {
      enable=true;
      extraSessionCommands = ''
	# SDL:
	      export SDL_VIDEODRIVER=wayland
	# QT (needs qt5.qtwayland in systemPackages):
	      export QT_QPA_PLATFORM=wayland-egl
	      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
	# Fix for some Java AWT applications (e.g. Android Studio),
	# use this if they aren't displayed properly:
	      export _JAVA_AWT_WM_NONREPARENTING=1
	      '';
      extraOptions = ["--unsupported-gpu"];
    };

    services.dbus.enable=true;

    environment.gnome.excludePackages = (with pkgs.gnome; [
        gnome-software
	geary
	totem
	gnome-music
	epiphany
    ]);
}
