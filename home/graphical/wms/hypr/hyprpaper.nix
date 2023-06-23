{...}: {
  xdg.configFile = {
    "hypr/hyprpaper.conf".text = ''
      preload = ${./wallpapers/night.png}
      # .. more preloads

      wallpaper = eDP-1,${./wallpapers/night.png}

      ipc=off
      splash=true
    '';
  };
}
