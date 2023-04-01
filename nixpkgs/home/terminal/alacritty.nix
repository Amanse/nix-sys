{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ "${./rose-pine.yml}" ];
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
