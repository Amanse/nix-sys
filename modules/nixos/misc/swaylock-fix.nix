{
  config,
  lib,
  ...
}: {
  options.myModules.misc.swaylock-fix = lib.mkEnableOption "use swaylock fix";

  config = lib.mkIf config.myModules.misc.swaylock-fix {
    security.pam.services.swaylock.text = ''
      # PAM configuration file for the swaylock screen locker. By default, it includes
      # the 'login' configuration file (see /etc/pam.d/login)
      auth include login
    '';
  };
}
