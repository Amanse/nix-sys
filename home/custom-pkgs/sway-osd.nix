{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.swayosd;
in {
  options.services.swayosd-mine = {
    enable = mkEnableOption ''
      swayosd, a GTK based on screen display for keyboard shortcuts like
      caps-lock and volume'';

    package = mkPackageOption pkgs "swayosd" {};

    maxVolume = mkOption {
      type = types.nullOr types.ints.unsigned;
      default = null;
      example = 120;
      description = ''
        Sets the maximum volume.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    systemd.user = {
      services.swayosd-mine = {
        Unit = {
          Description = "Volume/backlight OSD indicator";
          PartOf = ["graphical-session.target"];
          After = ["graphical-session.target"];
          ConditionEnvironment = "WAYLAND_DISPLAY";
          Documentation = "man:swayosd(1)";
        };

        Service = {
          Type = "simple";
          ExecStart = "${cfg.package}/bin/swayosd-server";
          Restart = "always";
        };

        Install = {WantedBy = ["graphical-session.target"];};
      };
    };
  };
}
