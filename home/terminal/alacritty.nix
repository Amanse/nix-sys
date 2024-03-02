{config, ...}: {
  programs.alacritty = {
    enable = config.wayland.windowManager.hyprland.enable || config.wayland.windowManager.sway.enable;
    settings = {
      import = ["${./rose-pine.toml}"];
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
