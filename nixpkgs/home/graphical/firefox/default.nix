{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles."me" = {
        id=0;
        isDefault=true;
    };
  };
}
