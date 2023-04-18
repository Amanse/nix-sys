{ pkgs, lib }:
{
  layer = "top";
  position = "top";
  modules-left = [
    "wlr/workspaces"
    "temperature"
    "hyprland/window"
    "custom/music"
  ];
  modules-right = [
    "tray"
    "idle_inhibitor"
    "pulseaudio"
    "backlight"
    "memory"
    "cpu"
    "battery"
    "battery#bat2"
    "network"
    "clock"
  ];
  "wlr/workspaces" = {
    "format" = "{icon}";
    "all-outputs" = true;
    "format-icons" = {
      "1" = "<span color=\"#019733\"></span>";
      "2" = "<span color=\"#FF7139\"></span>";
      "3" = "<span color=\"#757575\"></span>";
      "4" = "<span color=\"#26A5E4\"></span>";
      "5" = "<span color=\"#0A84FF\"></span>";
      "6" = "<span color=\"#a738fd\"></span>";
      "7" = "<span color=\"#019733\">7</span>";
      "8" = "<span color=\"#757575\">8</span>";
      "9" = "<span color=\"#26A5E4\"></span>";
    };
    "on-scroll-up" = "hyprctl dispatch workspace e+1";
    "on-scroll-down" = "hyprctl dispatch workspace e-1";
    "on-click" = "activate";
    "focused" = "";
    "default" = "";
  };
  "idle_inhibitor" = {
    "format" = "{icon}";
    "format-icons" = {
      "activated" = "";
      "deactivated" = "";
    };
    "tooltip" = false;
  };
  # "backlight" = {
  #   "device" = "intel_backlight";
  #   "on-scroll-up" = "light -A 5";
  #   "on-scroll-down" = "light -U 5";
  #   "format" = "{icon} {percent}%";
  #   "format-icons" = [ "" "" "" "" ];
  # };
  "pulseaudio" = {
    "format" = "{icon} {volume}%";
    "format-muted" = "婢 Muted";
    "max-volume" = 200;
    "format-icons" = {
      "default" = [ "" "" "" ];
    };
    "states" = {
      "warning" = 150;
    };
    "scroll-step" = 1;
    "on-click" = "${lib.getExe pkgs.pavucontrol}";
    "tooltip" = false;
  };
  "clock" = {
    "interval" = 1;
    "format" = "{:%H:%M %b %d}";
    "tooltip" = true;
    "today-format" = "<span color='#ff6699'><b>{}</b></span>";
    "tooltip-format" = "{:%A %B %Y}\n<tt>{calendar}</tt>";
  };
  "memory" = {
    "interval" = 1;
    "format" = "﬙ {percentage}%";
    "states" = {
      "warning" = 85;
    };
  };
  "battery" = {
    "states" = {
      # "good"= 95;
      "warning" = 15;
      "critical" = 10;
    };
    "format" = "{capacity}% {icon}";
    "format-charging" = "{capacity}% ";
    "format-plugged" = "{capacity}% ";
    "format-alt" = "{time} {icon}";
    # "format-good"= ""; // An empty format will hide the module
    # "format-full"= "";
    "format-icons" = [ "" "" "" "" "" ];
  };
  "battery#bat2" = {
    "bat" = "BAT2";
  };
  "cpu" = {
    "interval" = 1;
    "format" = " {usage}%";
  };
  "custom/music" = {
    "format" = "{}";
    "interval" = 1;
    "exec-if" = "${lib.getExe pkgs.playerctl} metadata";
    "exec" = pkgs.writeShellScript "music" ''
      #!/usr/bin/env bash
      if [[ $(${lib.getExe pkgs.playerctl} metadata artist) ]]
      then
        echo $(${lib.getExe pkgs.playerctl} metadata artist) - $(${lib.getExe pkgs.playerctl} metadata title)
      else
        echo $(${lib.getExe pkgs.playerctl} metadata title)
      fi
    '';
  };
  "network" = {
    "interval" = 1;
    "format-wifi" = "說 {essid}";
    "format-ethernet" = " {ipaddr}";
    "format-linked" = "說 {essid}";
    "format-disconnected" = "說 Disconnected";
    "tooltip" = false;
  };
  "temperature" = {
    "hwmon-path" = "/sys/class/hwmon/hwmon6/temp2_input";
    "tooltip" = false;
    "format" = " {temperatureC}°C";
  };
  "tray" = {
    "icon-size" = 14;
    "spacing" = 5;
  };
}
