{pkgs, ...}: {
  programs.neovim-flake = {
    enable = true;
    settings = {
      vim.lsp = {
        formatOnSave = true;
        nvimCodeActionMenu.enable = true;
      };

      vim.useSystemClipboard = false;

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

      vim.startPlugins = [pkgs.vimPlugins.undotree];
      vim.luaConfigRC = {
        after = ''
          -- Undodir
          vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
          vim.opt.undofile = true
        '';
      };

      vim.preventJunkFiles = true;

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

      vim.git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions = true;
      };

      vim.comments = {
        comment-nvim.enable = true;
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
        "<leader>p" = "\"_dP";
        "<leader>y" = "\"+y";
        "<leader>u" = ":UndotreeToggle<CR>";
        "<leader>f" = ":lua vim.lsp.buf.format()<CR>";
        "<leader>d" = "\"_d";
      };
      vim.vnoremap = {
        "<leader>y" = "\"+y";
        "<leader>p" = "\"_dP";
        "<leader>d" = "\"_d";
      };
    };
  };
}
