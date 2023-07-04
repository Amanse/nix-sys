{
  config,
  lib,
  pkgs,
  ...
}: 
{
  #intel
  #boot.initrd.kernelModules = ["i915"];

  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
    opengl.enable = true;
  };

  #------------------------------
  #Nvidia

  #hardware.opengl.extraPackages = with pkgs; [
  #  vaapiVdpau
  #];

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = false;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    package = config.boot.kernelPackages.nvidiaPackages.production;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
      intelBusId = "PCI:0:2:0";
      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
