{...}: {
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        theme = "modern";
        icons = "awesome6";
      };
    };
  };
}
