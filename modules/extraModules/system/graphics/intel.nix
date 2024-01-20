{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myModules.graphics;
in {
  config = lib.mkIf cfg.intel.enable {
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
    };

    hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [vaapiIntel];
  };
}
