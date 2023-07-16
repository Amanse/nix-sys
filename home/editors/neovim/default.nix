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
        ts = {
          enable = true;
          lsp.enable = true;
          treesitter = {
            enable = true;
          };
        };
        go.enable = true;
        svelte.enable = true;
      };

      vim.treesitter = {
        enable = true;
        grammars = [pkgs.tree-sitter-grammars.tree-sitter-svelte pkgs.tree-sitter-grammars.tree-sitter-typescript];
      };

      vim.startPlugins = [pkgs.vimPlugins.undotree pkgs.vimPlugins.harpoon];
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
          theme = "tokyonight";
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
        name = "tokyonight";
        style = "night";
        transparent = true;
      };
      vim.autopairs.enable = true;

      vim.autocomplete = {
        enable = true;
        type = "nvim-cmp";
      };

      vim.telescope.enable = true;

      vim.maps = {
        normal = {
          "<leader>pf" = {action = ":Telescope find_files<CR>";};
          "<leader>p" = {action = "\"_dP";};
          "<leader>y" = {action = "\"+y";};
          "<leader>u" = {action = ":UndotreeToggle<CR>";};
          "<leader>f" = {action = ":lua vim.lsp.buf.format()<CR>";};
          "<leader>d" = {action = "\"_d";};
          # "<leader>a" = ":lua require(\"harpoon.mark\").add_file()<CR>";
          # "<leader>q" = ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>";
          "<leader>pv" = {action = ":E<CR>";};
        };
        visual = {
          "<leader>y" = {action = "\"+y";};
          "<leader>p" = {action = "\"_dP";};
          "<leader>d" = {action = "\"_d";};
        };
      };
    };
  };
}
