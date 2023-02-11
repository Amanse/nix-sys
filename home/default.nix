{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    # import system packages
    ./packages

    # apps and services I use
    ./graphical
    ./services
  ];
  config = {
    home = {
      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      # I will personally strangle every moron who just puts "DONT CHANGE" next
      # to this value
      stateVersion = "22.11";
    };
    manual.manpages.enable = false;
  };
}
