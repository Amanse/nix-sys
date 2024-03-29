{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs = {
    adb.enable = true;

    kdeconnect = {
      # package = pkgs.libsForQt5.kdeconnect-kde;
      enable = true;
    };

    light.enable = true;

    gamemode = {
      enable = true;
      settings = {
        gpu = {
          gpu_device = 1;
        };
      };
    };

    gamescope = {
      enable = true;
      env = {INTEL_DEBUG = "noccs";};
      # capSysNice = true;
    };

    # hyprland = {
    #   enable = true;
    #   portalPackage = inputs
    # };

    auto-cpufreq.enable = true;

    dconf.enable = true;

    seahorse.enable = !config.services.desktopManager.plasma6.enable;
  };

  services.dbus.packages = with pkgs; [libsecret gnome.gnome-keyring gcr];

  # disabledModules = ["programs/hyprland.nix"];
  #
  # services.xserver.displayManager.sessionPackages = [inputs.hyprland.packages.${pkgs.system}.default];
  #
  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
  #   ];
  # };

  environment.systemPackages = with pkgs; [
    vim
    #neovim
    htop
    wget
    acpi
    gnome.gnome-tweaks
    # seatd # service enabled already

    inputs.sddm-catppuccin.packages.${pkgs.hostPlatform.system}.sddm-catppuccin
    catppuccin-sddm-corners

    nh

    #hyprland
    # hyprland-share-picker
  ];
}
