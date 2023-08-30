{
  pkgs,
  config,
  ...
}: {
  programs = {
    bottom = {
      enable = true;
      settings = {
        flags.group_processes = true;
        row = [
          {
            ratio = 2;
            child = [
              {type = "cpu";}
              {type = "mem";}
            ];
          }
          {
            ratio = 3;
            child = [
              {
                type = "net";
                ratio = 1;
              }
              {
                type = "disk";
                ratio = 1;
              }
              {
                type = "proc";
                ratio = 2;
                default = true;
              }
            ];
          }
        ];
      };
    };

    mpv = {
      enable = true;
      config = {
        force-window = true;
        hwdec = "auto-safe";
        vo = "gpu";
        profile = "gpu-hq";
        gpu-context = "wayland";
      };
    };

    go.enable = true;

    zellij.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    nix-index-database.comma.enable = true;

    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };

    alacritty = {
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

    lf = {
      enable = true;
      settings = {
        number = true;
        ratios = [
          1
          1
          2
        ];
        tabstop = 4;
      };
    };
  };
}
