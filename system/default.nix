{...}: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./nix-settings.nix
    # ./locale.nix
    ./programs.nix
    ./services.nix
    # ./greetd.nix
    ./mounts.nix
    # ./unsafe-performance.nix

    # ./sway.nix
  ];
}
