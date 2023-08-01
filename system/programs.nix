{pkgs, ...}: {
  programs = {
    adb.enable = true;

    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };

    steam = {
      enable = true;
      #	gamescopeSession.enable = true; #steamos like big picture mode session
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    #neovim
    htop
    wget
    acpi
    gnome.gnome-tweaks
  ];
}
