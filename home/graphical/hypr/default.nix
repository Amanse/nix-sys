{pkgs, ...}: {
  home.packages = with pkgs; [alacritty rofi-wayland wlsunset wayshot grim batsignal mako playerctl pamixer swaynotificationcenter];

  imports = [./hyprpaper.nix];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
    settings = {
      "$mod" = "SUPER";
      exec-once = ["${pkgs.hyprpaper}/bin/hyprpaper"];
      bind = [
        '',107,exec, ${pkgs.wayshot}/bin/wayshot --stdout | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png && ${pkgs.wl-clipboard}/bin/wl-paste > ~/Pictures/$(date + "%D-%T") ''

        ''$mod,107,exec, ${pkgs.wayshot}/bin/wayshot -s "$(${pkgs.slurp}/bin/slurp -f '%x %y %w %h')" --stdout | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png && ${pkgs.wl-clipboard}/bin/wl-paste > ~/Pictures/$(date + "%D-%T") ''
      ];
    };
    systemd.enable = true;
  };
}
