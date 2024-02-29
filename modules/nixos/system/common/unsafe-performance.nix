{
  config,
  lib,
  ...
}: {
  options.myModules.system.unsafePerformance = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.myModules.system.unsafePerformance {
    boot = {
      kernel.sysctl."kernel.split_lock_mitigate" = 0;
      kernelParams = ["mitigations=off"];
    };

    services.journald.extraConfig = "SystemMaxUse=50M";
  };
}
