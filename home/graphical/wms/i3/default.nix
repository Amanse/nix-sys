{
  config,
  lib,
  pkgs,
  ...
}: {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
        }
      ];
      window.titlebar = true;
      fonts.size = 9.0;
      focus.wrapping = "yes";
      assigns = {
        "2" = [{class = "^Brave-browser$";}];
      };
      terminal = "alacritty";
      modifier = "Mod4";
      menu = "bemenu-run -n | wmenu | xargs swaymsg exec --";
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
      startup = [
        {command = "mako";}
        {command = "mrpis-proxy";}
        {command = "mega-cmd-server";}
      ];
      floating.modifier = "Mod4";
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        menu = config.wayland.windowManager.sway.config.menu;
      in
        lib.mkOptionDefault {
          "${modifier}+r" = "exec " + menu;
          "${modifier}+b" = "exec ${pkgs.brave}/bin/brave";
          "${modifier}+q" = "kill";
          "${modifier}+e" = "exec thunar";
          "${modifier}+N" = "exec logseq";
          #Brightness
          "XF86MonBrightnessUp" = "exec light -A 5";
          "XF86MonBrightnessDown" = "exec light -U 5";

          #volume
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";

          #Pause play media
          "${modifier}+space" = "exec playerctl play-pause";
          "${modifier}+Shift+space" = "focus mode_toggle";

          #screenshot
          "${modifier}+Print" = ''exec ${pkgs.wayshot}/bin/wayshot -s "$(${pkgs.slurp}/bin/slurp -f '%x %y %w %h')" --stdout | wl-copy --type image/png && wl-paste > ~/Pictures/$(date +"%T").png '';
          "Print" = ''exec ${pkgs.wayshot}/bin/wayshot --stdout | wl-copy --type image/png && wl-paste > ~/Pictures/$(date +"%T").png '';

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
    #extraConfig = builtins.readFile ./config;
  };
}
