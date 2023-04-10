{ neovim-flake, ... }: {
  imports = [
    neovim-flake.homeManagerModules.default
  ];

  programs.neovim-flake = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 20;
          logFile = "/tmp/nvim.log";
        };
      };

      vim.lsp = {
        enable = true;
        formatOnSave = true;
        lightbulb.enable = true;
        lspsaga.enable = false;
        nvimCodeActionMenu.enable = true;
        #trouble.enable = true;
        #lspSignature.enable = true;
        rust.enable = true;
        #python = isMaximal;
        #clang.enable = isMaximal;
        #sql = isMaximal;
        #ts = isMaximal;
        #go = isMaximal;
        #zig.enable = isMaximal;
        nix = {
          enable = true;
          formatter = "alejandra";
        };
      };

      vim.statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };
      };

      vim.theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };
      vim.autopairs.enable = true;

      vim.autocomplete = {
        enable = true;
        type = "nvim-cmp";
      };

      vim.filetree = {
        nvimTreeLua = {
          enable = true;
          view = {
            width = 25;
          };
        };
      };

      vim.treesitter = {
        enable = true;
        context.enable = true;
      };

      vim.binds = {
        whichKey.enable = true;
        vim.treesitter = {
          enable = true;
          context.enable = true;
        };

        vim.binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        vim.telescope = {
          enable = true;
        };

        vim.markdown = {
          enable = true;
          glow.enable = true;
        };

        vim.git = {
          enable = true;
          gitsigns.enable = true;
        };
        cheatsheet.enable = true;
      };

      vim.telescope = {
        enable = true;
      };

      vim.markdown = {
        enable = true;
        glow.enable = true;
      };

      vim.git = {
        enable = true;
        gitsigns.enable = true;
      };
    };
  };
}
