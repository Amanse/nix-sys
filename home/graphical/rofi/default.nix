{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  programs.rofi = {
    enable = true;
    theme= "android_notification";
};

}


