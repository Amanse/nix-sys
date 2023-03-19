{ pkgs, config, ... }:
let
  mountdir = "${config.home.homeDirectory}/onedrive";
in
{
  systemd.user = {
    services.onedrive_mount = {
      Unit = {
        Description = "mount onedrive dirs";
        After = [ "network-online.target" ];
      };
      Install.WantedBy = [ "multi-user.target" ];
      Service = {
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${mountdir}";
        ExecStart = ''
          ${pkgs.rclone}/bin/rclone mount drive: ${mountdir} \
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
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };

  };
}
