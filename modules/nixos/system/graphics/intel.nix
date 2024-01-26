{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myModules.graphics;
  vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
in {
  config = lib.mkIf cfg.intel.enable {
    services.xserver.videoDrivers = ["modesetting"];

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        # intel-compute-runtime # FIXME does not build due to unsupported system
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    boot.initrd.kernelModules = ["i915"];
  };
}
