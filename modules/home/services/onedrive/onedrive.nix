{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf getExe';
  # inherit (builtins) concatStringsSep;

  cfg = config.myHome.services.onedrive;
  onedriveExe = "${getExe' pkgs.onedrive "onedrive"}";
in {
  config = mkIf cfg.enable {
    systemd.user.services.onedrive-client = {
      Unit = {
        Description = "OneDrive client";
        After = ["network-online.target"];
        Wants = ["network-online.target"];
      };
      Install.WantedBy = ["default.target"];
      Service = {
        ExecStart = ''${onedriveExe} --monitor'';
        Restart = "on-failure";
        RestartSec = "3s";
      };
    };

    # xdg.configFile."onedrive/sync_list" = {
    #   text = ''
    #     ${concatStringsSep "\n" cfg.syncDirs}
    #   '';
    #   onChange = "${onedriveExe} --resync-auth --synchronize";
    # };
  };
}
