{
  pkgs,
  xdg-portal-hyprland,
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
    autorun = false;
    displayManager.defaultSession = "hyprland";
    displayManager.startx.enable = true;
    #desktopManager.xterm.enable = true;
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
    windowManager.i3 = {
      enable = true;
    };
    layout = "us";
  };

  services.dbus.enable = true;

  # programs.hyprland = {
  #   enable = true;
  #   package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland-nvidia;
  #   #nvidiaPatches = true;
  # };

  #  environment.gnome.excludePackages = (with pkgs.gnome; [
  #    gnome-software
  #    geary
  #    totem
  #    gnome-music
  #    epiphany
  #  ]);

  xdg.portal = {
    enable = true;
    extraPortals = [xdg-portal-hyprland.packages."x86_64-linux".default];
  };
}
