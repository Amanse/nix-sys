{...}: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./nix-settings.nix
    ./programs.nix
    ./services.nix
    # ./greetd.nix
    ./mounts.nix
    ./unsafe-performance.nix

    ./virtualisation.nix

    ./virtualisation-kali-college.nix

    ./sway.nix
  ];
}
