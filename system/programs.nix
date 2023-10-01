{pkgs, ...}: {
  programs = {
    adb.enable = true;

    kdeconnect = {
      enable = true;
    };

    light.enable = true;

    steam = {
      enable = true;
      #	gamescopeSession.enable = true; #steamos like big picture mode session
    };

    hyprland = {
      enable = true;
    };

    auto-cpufreq.enable = true;
  };

  services.dbus.packages = with pkgs; [hyprland libsecret];

  environment.systemPackages = with pkgs; [
    vim
    #neovim
    htop
    wget
    acpi
    gnome.gnome-tweaks
    seatd

    #hyprland
    # hyprland-share-picker
  ];
}
