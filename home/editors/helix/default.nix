{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha_transparent";
      keys.normal = {
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        "X" = "extend_line_above";
      };
      languages = {
        language = [
          {
            name = "rust";
            auto-format = false;
          }
          {
            name = "nix";
          }
        ];
      };
    };
  };

  home.packages = with pkgs; [nil];
}
