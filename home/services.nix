{
  pkgs,
  config,
  lib,
  ...
}: {
  systemd.user.services = lib.mkIf config.myHome.gui.wms.enable {
    swayosd-mine = {
      Unit = {
        Description = "Volume/backlight OSD indicator";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Documentation = "man:swayosd(1)";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
        Restart = "always";
        RestartSec = "10s";
      };

      Install = {WantedBy = ["graphical-session.target"];};
    };
  };

  services = {
    mpris-proxy.enable = true;

    kdeconnect = {
      enable = true;
      indicator = true;
    };
    #
    # gnome-keyring.enable = true;
    # syncthing = {
    #   enable = true;
    #   tray.enable = true;
    # };
  };
}
