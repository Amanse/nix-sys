{inputs, ...}: {
  imports = [
    inputs.neovim-flake.homeManagerModules.default
    inputs.nix-index-database.hmModules.nix-index
    # inputs.hyprland.homeManagerModules.default

    ./packages.nix
    ./terminal
    ./services.nix
    ./programs.nix
    ./graphical
    ./theme.nix
  ];
  home.username = "me";
  home.homeDirectory = "/home/me";

  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "nemo.desktop";

    # Browser
    "text/html" = "thorium-browser.desktop";
    "x-scheme-handler/http" = "thorium-browser.desktop";
    "x-scheme-handler/https" = "thorium-browser.desktop";
    "x-scheme-handler/about" = "thorium-browser.desktop";
    "x-scheme-handler/unknown" = "thorium-browser.desktop";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # is set to something in the nix store by default
  # programs.home-manager.path = "$HOME/nix-sys/home";
  # };
  # home-manager.extraSpecialArgs = {inherit inputs;};
}
