{pkgs, ...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    monitor=,preferred,auto,1
    #eww fix maybe

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    # exec-once = waybar & hyprpaper & firefox

    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =

        follow_mouse = 1

        touchpad {
            natural_scroll = yes
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

     general {
        gaps_in = 2
        gaps_out = 2
        border_size = 1
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
        layout = dwindle
      }
      decoration {
        inactive_opacity = 0.95
        drop_shadow = yes
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
      }
      animations {
        enabled = yes
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
      }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
    }

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = on
    }

    misc {
        focus_on_activate=true
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
    device:epic mouse V1 {
        sensitivity = -0.5
    }


    # Example windowrule v1
    # Example windowrule v2
    ## windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    windowrulev2 = tile, title:^(Spotify)$
    windowrulev2 = workspace 4 silent, title:^(Spotify)$

    # windowrulev2 = workspace 3 silent, title:^(Steam)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

    layerrule = blur, waybar

    # disable_hypr_chan=true


    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = SUPER

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, RETURN, exec, ${pkgs.alacritty}/bin/alacritty
    bind = $mainMod, S, exec, steam
    bind = $mainMod, N, exec, obsidian
    bind = $mainMod, Q, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, E, exec, ${pkgs.cinnamon.nemo-with-extensions}/bin/nemo
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, R, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle
    bind = $mainMod, B, exec, thorium
    bind = $mainMod, Space, exec, ${pkgs.playerctl}/bin/playerctl play-pause
    # bind = $mainMod, Period, exec, bemoji
    #logout menu
    bind = $mainMod, Escape, exec, swaylock
    bindl=,switch:[Lid Switch],exec,swaylock

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    bind = $mainMod SHIFT, left, workspace, e-1
    bind = $mainMod SHIFT, right, workspace, e+1

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    bind = $mainMod ALT, 1, movetoworkspacesilent, 1
    bind = $mainMod ALT, 2, movetoworkspacesilent, 2
    bind = $mainMod ALT, 3, movetoworkspacesilent, 3
    bind = $mainMod ALT, 4, movetoworkspacesilent, 4
    bind = $mainMod ALT, 5, movetoworkspacesilent, 5
    bind = $mainMod ALT, 6, movetoworkspacesilent, 6
    bind = $mainMod ALT, 7, movetoworkspacesilent, 7
    bind = $mainMod ALT, 8, movetoworkspacesilent, 8
    bind = $mainMod ALT, 9, movetoworkspacesilent, 9
    bind = $mainMod ALT, 0, movetoworkspacesilent, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # will switch to a submap called resize
    bind=ALT,R,submap,resize

    # will start a submap called "resize"
    submap=resize

    # sets repeatable binds for resizing the active window
    binde=,right,resizeactive,10 0
    binde=,left,resizeactive,-10 0
    binde=,up,resizeactive,0 -10
    binde=,down,resizeactive,0 10

    # use reset to go back to the global submap
    bind=,escape,submap,reset

    # will reset the submap, meaning end the current one and return to the global one
    submap=reset

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow

    #audio and brightness
    #bind=,XF86MonBrightnessUp,exec,light -A 5
    #bind=,XF86MonBrightnessDown,exec,light -U 5
    bind=,XF86MonBrightnessUp,exec,${pkgs.swayosd}/bin/swayosd --brightness=raise 5
    bind=,XF86MonBrightnessDown,exec,${pkgs.swayosd}/bin/swayosd --brightness=lower 5

    bind=,XF86AudioRaiseVolume,exec,${pkgs.swayosd}/bin/swayosd --output-volume=raise 5
    bind=,XF86AudioLowerVolume,exec,${pkgs.swayosd}/bin/swayosd --output-volume=lower 5
    bind=,XF86AudioMute,exec,${pkgs.swayosd}/bin/swayosd --output-volume=mute-toggle

    # screenshot
    bind = ,107,exec, ${pkgs.wayshot}/bin/wayshot --stdout | ${pkgs.swappy}/bin/swappy -f -
    bind = $mainMod,107,exec, ${pkgs.wayshot}/bin/wayshot -s "$(${pkgs.slurp}/bin/slurp -f '%x %y %w %h')" --stdout | ${pkgs.swappy}/bin/swappy -f -

    bind = $mainMod, F, exec, hyprctl dispatch fullscreen 0
    bind = $mainMod, g, exec, hyprctl dispatch fullscreen 1

    #Screensharing and xdg-portal-wlr
    exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    #Waybar
    exec-once=${pkgs.waybar}/bin/waybar
    exec-once=${pkgs.megacmd}/bin/mega-cmd-server
    exec-once=${pkgs.wlsunset}/bin/wlsunset -T 4501
    #Notification
    exec-once=${pkgs.swaynotificationcenter}/bin/swaync
    exec-once=dbus-launch kdeconnect-cli
    #wallpaper
    exec-once=${pkgs.hyprpaper}/bin/hyprpaper
    exec = ${pkgs.batsignal}/bin/batsignal -b -w 20

  '';

  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";

    windowrulev2 = [
      "workspace 2 silent, title:^(.*)(- Brave)$"
      "workspace 2 silent, title:^(.*)(- Thorium)$"
      "workspace 3 silent, title:^(Steam)$"
    ];

    bind = [
      ",180, exec, steam steam://open/bigpicture"
      # "$mainMod, E, exec, ${pkgs.cinnamon.nemo-with-extensions}/bin/nemo"

      # # Screenshot tooling
      # '',107,exec, ${pkgs.wayshot}/bin/wayshot --stdout | ${pkgs.swappy}/bin/swappy -f - ''
      #
      # ''$mod,107,exec, ${pkgs.wayshot}/bin/wayshot -s "$(${pkgs.slurp}/bin/slurp -f '%x %y %w %h')" --stdout | ${pkgs.swappy}/bin/swappy -f - ''
    ];

    # exec-once = ["${pkgs.hyprpaper}/bin/hyprpaper"];
  };
}