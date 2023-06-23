{
  pkgs,
  config,
  ...
}: {
  environment.pathsToLink = ["/libexec"];
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
  };

  services.xserver = {
    enable = true;
    #autorun = false;
    displayManager.defaultSession = "hyprland";
    #displayManager.startx.enable = true;
    displayManager.gdm.enable = false;
    displayManager.lightdm.enable = false;
    # displayManager.sddm.enable = true;
    desktopManager.gnome.enable = true;
    # desktopManager.plasma5.enable = true;
    #desktopManager.xterm.enable = true;
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
    windowManager.i3 = {
      enable = true;
    };
    layout = "us";
  };

  services.dbus.enable = true;

  programs.hyprland = {
    enable = true;
  };

  environment.gnome.excludePackages = with pkgs.gnome; [
    gnome-software
    geary
    totem
    gnome-music
    epiphany
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
