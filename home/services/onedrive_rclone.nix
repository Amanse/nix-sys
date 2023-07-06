{
  pkgs,
  config,
  ...
}: let
  mountdir = "${config.home.homeDirectory}/onedrive";
  mountdir1 = "${config.home.homeDirectory}/onedrive-val";
in {
  systemd.user = {
    services.onedrive_mount = {
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

    # services.onedrive_mount_val = {
    #   Unit = {
    #     Description = "mount onedrive dirs";
    #     After = [ "network-online.target" ];
    #   };
    #   Install.WantedBy = [ "default.target" ];
    #   Service = {
    #     ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${mountdir1}";
    #     ExecStart = ''
    #       ${pkgs.rclone}/bin/rclone mount onedrive-val: ${mountdir1} \
    #           --dir-cache-time 48h \
    #           --vfs-cache-mode full \
    #           --vfs-cache-max-age 48h \
    #           --vfs-read-chunk-size 10M \
    #           --vfs-read-chunk-size-limit 512M \
    #           --buffer-size 512M \
    #           --ignore-existing \
    #           --transfers=4 \
    #           --checkers=16
    #     '';
    #     ExecStop = "/run/wrappers/bin/fusermount -u ${mountdir1}";
    #     Type = "notify";
    #     Restart = "always";
    #     RestartSec = "10s";
    #     Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
    #   };
    # };
    #
  };
}
