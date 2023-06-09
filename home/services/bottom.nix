{
  config,
  pkgs,
  ...
}: {
  # universal aliases
  home.packages = with pkgs; [
    # replace top and htop with bottom
    # if breaks shit? cope.
    (writeScriptBin "htop" ''exec btm'')
    (writeScriptBin "top" ''exec btm'')
  ];
  programs.bottom = {
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
}
