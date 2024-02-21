{pkgs, ...}: {
  systemd.user.services = {
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
    # syncthing = {
    #   enable = true;
    #   tray.enable = true;
    # };
  };
}
