{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  sessionData = config.services.xserver.displayManager.sessionData.desktops;
  sessionPath = lib.concatStringsSep ":" [
    "${sessionData}/share/xsessions"
    "${sessionData}/share/wayland-sessions"
  ];
in {
  config = lib.mkIf (builtins.elem "greetd" config.myModules.gui.loginManagers) {
    security.pam.services = {
      login = {
        enableGnomeKeyring = true;
      };

      greetd = {
        gnupg.enable = true;
        enableGnomeKeyring = true;
      };
    };

    services.xserver.displayManager.session = mkIf (builtins.elem "gnome" config.myModules.gui.desktops) [
      {
        manage = "desktop";
        name = "GNOME-wayland";
        start = ''
          XDG_SESSION_TYPE=wayland dbus-run-session ${pkgs.gnome.gnome-session}/bin/gnome-session
        '';
      }
    ];

    services.greetd = {
      enable = true;
      vt = 2;
      restart = true;
      settings = {
        default_session = {
          command = lib.concatStringsSep " " [
            (lib.getExe pkgs.greetd.tuigreet)
            "--time"
            "--remember"
            "--remember-user-session"
            "--asterisks"
            "--sessions '${sessionPath}'"
          ];
          user = "greeter";
        };
      };
    };
    #  programs.regreet.enable = true;
  };
}
