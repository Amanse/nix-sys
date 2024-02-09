{config, ...}: {
  imports = [./secure-boot.nix];

config.boot.loader.systemd-boot.enable = true;
    config.boot.loader.efi.canTouchEfiVariables = true;
}
