{ config, lib, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';

  minecraft-nvidia = pkgs.writeShellScriptBin "minecraft-nvidia" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "minecraft-launcher"
  '';
in
{
  #intel
  boot.initrd.kernelModules = [ "i915" ];

  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };

  #------------------------------
  #Nvidia

  environment.systemPackages = [ nvidia-offload minecraft-nvidia ];
  #hardware.opengl.extraPackages = with pkgs; [
  #  vaapiVdpau
  #];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = false;
    powerManagement = {
      enable = true;
      finegrained = true;
    };

    prime = {
      offload.enable = true;
      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
      intelBusId = "PCI:0:2:0";
      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:1:0:0";
    };

  };

}


