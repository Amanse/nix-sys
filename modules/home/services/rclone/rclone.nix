{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkMerge forEach;

  cfg = config.myHome.services.rclone;
  genService = (
    dir: cname: {
      ${cname} = {
        Unit = {
          Description = "mount onedrive dirs";
          After = ["network-online.target"];
        };
        Install.WantedBy = ["default.target"];
        Service = {
          ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${dir}";
          ExecStart = ''
            ${pkgs.rclone}/bin/rclone mount ${cname}: ${dir} \
                --dir-cache-time 48h \
                --vfs-cache-mode full \
                --vfs-cache-max-age 48h \
                --vfs-read-chunk-size 10M \
                --vfs-read-chunk-size-limit 512M \
                --buffer-size 512M
          '';
          ExecStop = "/run/wrappers/bin/fusermount -u ${dir}";
          Type = "notify";
          Restart = "always";
          RestartSec = "10s";
          Environment = ["PATH=/run/wrappers/bin/:$PATH"];
        };
      };
    }
  );

  toMerge = forEach cfg.configs (x: genService x.mountDir x.configName);
in {
  config.systemd.user.services = mkIf cfg.enable (mkMerge toMerge);
}
