{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ "${./rose-pine.yml}" ];
      window = {
        padding = {
          x = 2;
          y = 2;
        };
        dynamic_padding = true;
      };
    };
  };
}
