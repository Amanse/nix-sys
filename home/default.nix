{
  home-manager,
  inputs,
  ...
}: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.me = {
    imports = [
      inputs.neovim-flake.homeManagerModules.default

      ./packages.nix
      ./terminal
      ./services.nix
      ./programs.nix
    ];
    home.username = "me";
    home.homeDirectory = "/home/me";

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
  };
}
