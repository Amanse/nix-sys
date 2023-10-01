{...}: {
  xdg.configFile = {
    "hypr/hyprpaper.conf".text = ''
      preload = ${./night.png}

      wallpaper = ,${./night.png}

      ipc=false
      splash=true
    '';
  };
}
