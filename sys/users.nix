{ config, pkgs, ... }:

{
  users.users.me = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Aman";
    extraGroups = [ "networkmanager" "wheel" "power" "storage" "adbusers" "video" ];
    packages = with pkgs; [
      #
    ];
  };

  programs.zsh.enable = true;

}
