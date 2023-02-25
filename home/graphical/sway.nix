{ config, lib, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
    extraOptions = [ "--unsupported-gpu" ];
    config = {
      window.titlebar = true;
      fonts.size = 9.0;
      focus.wrapping = "yes";
      #left = "Left";
      #right = "Right";
      bars = [ ];
      assigns = {
        "2" = [{ app_id = "brave"; }];
      };
      terminal = "alacritty";
      modifier = "Mod4";
      menu = "bemenu-run | wmenu | xargs swaymsg exec --";
      output = {
        "*" = {
          bg = "/home/me/Pictures/Wallpapers/1e4df9cb550ea19c.png fill";
        };
      };
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
      startup = [
        { command = "waybar"; }
        { command = "mako"; }
        { command = "dbus-launch kdeconnect-cli"; }
      ];
      floating.modifier = "Mod4";
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
          menu = config.wayland.windowManager.sway.config.menu;
        in
        lib.mkOptionDefault {
          "${modifier}+r" = "exec " + menu;
          "${modifier}+b" = "exec ${pkgs.brave}/bin/brave";
          "${modifier}+q" = "kill";
          "${modifier}+e" = "exec nautilus";
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
          "Print" = "exec grim - |  wl-copy --type image/png";

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
