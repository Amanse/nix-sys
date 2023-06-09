{...}: {
  xdg.configFile = {
    "hypr/hyprpaper.conf".text = builtins.readFile ./hyprpaper.conf;
  };
}
