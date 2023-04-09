{ pkgs, config, ... }:
{
  environment.pathsToLink = [ "/libexec" ];
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
  };

  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = true;
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
    windowManager.i3 = {
      enable = true;
    };
    layout = "us";
  };

  services.dbus.enable = true;

  environment.gnome.excludePackages = (with pkgs.gnome; [
    gnome-software
    geary
    totem
    gnome-music
    epiphany
  ]);
}
