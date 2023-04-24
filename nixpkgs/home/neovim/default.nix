{...}: {
  programs.neovim-flake = {
    enable = true;
    settings = {
      vim.lsp = {
        formatOnSave = true;
        nvimCodeActionMenu.enable = true;
      };

      vim.languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;

        nix.enable = true;
        html.enable = true;
        clang.enable = true;
        rust = {
          enable = true;
          crates.enable = true;
        };
        ts.enable = true;
      };

      vim.visuals = {
        enable = true;
        nvimWebDevicons.enable = true;
        scrollBar.enable = true;
        smoothScroll.enable = true;
        cellularAutomaton.enable = true;
        fidget-nvim.enable = true;
        indentBlankline = {
          enable = true;
          fillChar = null;
          eolChar = null;
          showCurrContext = true;
        };
        cursorWordline = {
          enable = true;
          lineTimeout = 0;
        };
      };

      vim.statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };
      };

      vim.binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      vim.theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };
      vim.autopairs.enable = true;

      vim.autocomplete = {
        enable = true;
        type = "nvim-cmp";
      };

      vim.telescope.enable = true;

      vim.nnoremap = {
        "<leader>pf" = ":Telescope find_files<CR>";
        "<leader>p" = "[[\"_dP]]";
        "<leader>y" = "[[\"+y]]";
      };
      vim.vnoremap = {
        "<leader>y" = "[[\"+y]]";
      };
    };
  };
}
