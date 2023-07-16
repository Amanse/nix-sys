{
  pkgs,
  config,
  ...
}: {
  #environment.pathsToLink = ["/libexec"];

  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.gdm.enable = true;
    displayManager.startx.enable = true;
    displayManager.lightdm.enable = false;
    desktopManager.gnome.enable = true;
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
    exportConfiguration = true;
    layout = "us";
    #windowManager.i3.enable = true;
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
