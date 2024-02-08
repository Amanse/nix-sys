{
  pkgs,
  config,
  ...
}: let
  mountdir = "${config.home.homeDirectory}/onedrive";
  sharedir = "${config.home.homeDirectory}/onedrive-share";
in {
  systemd.user.services = {
    onedrive-main = {
      Unit = {
        Description = "mount onedrive dirs";
        After = ["network-online.target"];
      };
      Install.WantedBy = ["default.target"];
      Service = {
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${mountdir}";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount onedrive-main: ${mountdir} \
              --dir-cache-time 48h \
              --vfs-cache-mode full \
              --vfs-cache-max-age 48h \
              --vfs-read-chunk-size 10M \
              --vfs-read-chunk-size-limit 512M \
              --buffer-size 512M
        '';
        ExecStop = "/run/wrappers/bin/fusermount -u ${mountdir}";
        Type = "notify";
        Restart = "always";
        RestartSec = "10s";
        Environment = ["PATH=/run/wrappers/bin/:$PATH"];
      };
    };

    onedrive-share = {
      Unit = {
        Description = "mount onedrive dirs";
        After = ["network-online.target"];
      };
      Install.WantedBy = ["default.target"];
      Service = {
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${sharedir}";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount onedrive-val: ${sharedir} \
              --dir-cache-time 48h \
              --vfs-cache-mode full \
              --vfs-cache-max-age 48h \
              --vfs-read-chunk-size 10M \
              --vfs-read-chunk-size-limit 512M \
              --buffer-size 512M
        '';
        ExecStop = "/run/wrappers/bin/fusermount -u ${sharedir}";
        Type = "notify";
        Restart = "always";
        RestartSec = "10s";
        Environment = ["PATH=/run/wrappers/bin/:$PATH"];
      };
    };

    mega_sync = {
      Unit = {
        Description = "megasync";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };

      Install = {WantedBy = ["graphical-session.target"];};

      Service = {ExecStart = "${pkgs.megacmd}/bin/mega-cmd-server";};
    };
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
      };

      Install = {WantedBy = ["graphical-session.target"];};
    };
  };

  services = {
    swayosd-mine.enable = config.wayland.windowManager.hyprland.enable;
    mpris-proxy.enable = true;
    # syncthing = {
    #   enable = true;
    #   tray.enable = true;
    # };
  };
}
