{config, ...}: {
  programs.alacritty = {
    enable = config.wayland.windowManager.hyprland.enable;
    settings = {
      import = ["${./rose-pine.yml}"];
      font.size = 11.5;
      window = {
        opacity = 0.8;
        padding = {
          x = 2;
          y = 2;
        };
        dynamic_padding = true;
      };
    };
  };
}
