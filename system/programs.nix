{pkgs, ...}: {
  programs = {
    adb.enable = true;

    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };

    light.enable = true;

    steam = {
      enable = true;
      #	gamescopeSession.enable = true; #steamos like big picture mode session
    };

    hyprland = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    #neovim
    htop
    wget
    acpi
    gnome.gnome-tweaks

    #hyprland
    hyprland-share-picker
  ];
}
