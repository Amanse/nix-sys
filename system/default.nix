{...}: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./nix-settings.nix
    ./programs.nix
    ./services.nix
    ./nvidia.nix
    ./greetd.nix
  ];
}
