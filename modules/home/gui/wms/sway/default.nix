{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.myHome.gui.wms.sway;
in {
  wayland.windowManager.sway = {
    enable = cfg.enable;
    extraOptions = ["--unsupported-gpu"];
    # extraSessionCommands = ''
    #      export SDL_VIDEODRIVER=wayland
    #   # needs qt5.qtwayland in systemPackages
    #   export QT_QPA_PLATFORM=wayland
    #   export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
    #   # Fix for some Java AWT applications (e.g. Android Studio),
    #   # use this if they aren't displayed properly:
    #   export _JAVA_AWT_WM_NONREPARENTING=1
    # '';
    extraConfig = lib.optionalString (cfg.package == pkgs.swayfx) ''blur enable'';
    config = {
      window.titlebar = true;
      fonts.size = 9.0;
      focus.wrapping = "yes";
      #left = "Left";
      #right = "Right";
      bars = [];
      assigns = {
        "2" = [{class = "^Brave-browser$";}];
        "3" = [{title = "Steam";}];
      };
      terminal = config.myHome.terminal;
      modifier = "Mod4";
      menu = "${pkgs.rofi-wayland}/bin/rofi -show drun";
      input = {
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
      };
      modes = {
        resize = {
          Down = "resize grow height 10 px";
          Escape = "mode default";
          Left = "resize shrink width 10 px";
          Return = "mode default";
          Right = "resize grow width 10 px";
          Up = "resize shrink height 10 px";
          h = "resize shrink width 10 px";
          j = "resize grow height 10 px";
          k = "resize shrink height 10 px";
          l = "resize grow width 10 px";
        };
      };

      startup = map (x: {command = x;}) config.myHome.startupCmds;
      floating.modifier = "Mod4";
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        menu = config.wayland.windowManager.sway.config.menu;
      in
        lib.mkOptionDefault {
          "${modifier}+r" = "exec " + menu;
          "${modifier}+b" = "exec " + config.myHome.browser;
          "${modifier}+q" = "kill";
          "${modifier}+e" = "exec nautilus";
          "${modifier}+N" = "exec logseq";
          #Brightness
          "XF86MonBrightnessUp" = "exec light -A 5";
          "XF86MonBrightnessDown" = "exec light -U 5";

          #volume
          "XF86AudioRaiseVolume" = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume=raise 5 --max-volume=200";
          "XF86AudioLowerVolume" = "exec ${pkgs.swayosd}/bin/swayosd-client --output-volume=lower 5 --max-volume=200";
          "XF86AudioMute" = "${pkgs.swayosd}/bin/swayosd-client --output-volume=mute-toggle";

          "XF86HomePage" = "exec steam steam://open/bigpicture";

          #Pause play media
          "${modifier}+space" = "exec playerctl play-pause";
          "${modifier}+Shift+space" = "focus mode_toggle";

          #screenshot
          "${modifier}+Print" = ''exec ${pkgs.wayshot}/bin/wayshot -s "$(${pkgs.slurp}/bin/slurp -f '%x %y %w %h')" --stdout | wl-copy --type image/png && wl-paste > ~/Pictures/$(date +"%T").png '';
          # "Print" = ''exec ${pkgs.wayshot}/bin/wayshot --stdout | wl-copy --type image/png && wl-paste > ~/Pictures/$(date +"%T").png '';
          "Print" = ''exec ${pkgs.grimblast}/bin/grimblast --notify --cursor copysave screen'';

          "${modifier}+Shift+r" = "reload";
          "${modifier}+Period" = "exec bemoji";
          "${modifier}+Shift+Period" = "exec bemoji -t";

          "${modifier}+Shift+b" = "splith";
          "${modifier}+v" = "floating toggle";

          # Switch the current container between different layout styles
          "${modifier}+s" = "layout stacking";
          "${modifier}+g" = "layout toggle tabbed split";
          "${modifier}+j" = "layout toggle split";

          # Make the current focus fullscreen
          "${modifier}+f" = "fullscreen";

          "Alt+r" = "mode resize";
        };
    };
  };
  # systemd.xdgAutostart = true;
}
