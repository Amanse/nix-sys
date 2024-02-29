{pkgs, ...}: {
  home.packages = [pkgs.ripgrep]; # Need only for this, otherwise uses the alias of grep

  programs.neovim-flake = {
    enable = true;
    settings = {
      vim = {
        lsp = {
          enable = true;
          formatOnSave = true;
          nvimCodeActionMenu.enable = true;
          lightbulb.enable = true;
        };

        useSystemClipboard = false;

        languages = {
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
          java.enable = true;
          java.lsp.enable = true;
          java.treesitter.enable = true;
          markdown.enable = true;
          tailwind.enable = true;
          # markdown.glow.enable = true;
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

        treesitter = {
          enable = true;
          grammars = [pkgs.tree-sitter-grammars.tree-sitter-svelte pkgs.tree-sitter-grammars.tree-sitter-typescript pkgs.tree-sitter-grammars.tree-sitter-embedded-template];
        };

        extraPlugins = with pkgs.vimPlugins; {
          harpoon = {
            package = pkgs.harpoon;
            setup = ''
                                          local harpoon = require("harpoon")

                                          -- REQUIRED
                                          harpoon:setup()
                            harpoon:setup({})
                                          -- REQUIRED

              vim.keymap.set("n", "<C-a>", function() harpoon:list():select(1) end)
              vim.keymap.set("n", "<C-s>", function() harpoon:list():select(2) end)
              vim.keymap.set("n", "<C-d>", function() harpoon:list():select(3) end)
              vim.keymap.set("n", "<C-f>", function() harpoon:list():select(4) end)

                            -- basic telescope configuration
                            local conf = require("telescope.config").values
                            local function toggle_telescope(harpoon_files)
                                local file_paths = {}
                                for _, item in ipairs(harpoon_files.items) do
                                    table.insert(file_paths, item.value)
                                end

                                require("telescope.pickers").new({}, {
                                    prompt_title = "Harpoon",
                                    finder = require("telescope.finders").new_table({
                                        results = file_paths,
                                    }),
                                    previewer = conf.file_previewer({}),
                                    sorter = conf.generic_sorter({}),
                                }):find()
                            end

                            vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
                  { desc = "Open harpoon window" })
            '';
            after = ["plenary-nvim"];
          };

          undodir = {
            package = undotree;
            setup = ''
              vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
              vim.opt.undofile = true
            '';
          };
        };

        optPlugins = ["plenary-nvim"];

        # vim.startPlugins = [pkgs.vimPlugins.undotree pkgs.vimPlugins.harpoon];
        luaConfigRC = {
          after = "vim.filetype.add({extension = {ejs = \"html\"}})\n";
        };

        preventJunkFiles = true;

        visuals = {
          enable = true;
          nvimWebDevicons.enable = true;
          indentBlankline = {
            enable = true;
            fillChar = null;
            eolChar = null;
            scope.enabled = true;
          };
          highlight-undo.enable = true;
          # cursorline.enable = true;
          fidget-nvim.enable = true;
          # cursorWordline = {
          #   enable = true;
          #   lineTimeout = 0;
          # };
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "catppuccin";
          };
        };

        binds = {
          whichKey.enable = true;
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          # gitsigns.codeActions = true;
        };

        comments = {
          comment-nvim.enable = true;
        };

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };
        autopairs.enable = true;

        autocomplete = {
          enable = true;
          type = "nvim-cmp";
        };

        telescope = {
          enable = true;
          mappings = {
            findFiles = "<leader>pf";
          };
        };

        tabline.nvimBufferline = {
          enable = true;
          mappings = {
            closeCurrent = "<leader>bx";
          };
        };

        ui = {
          breadcrumbs.enable = true;
        };

        maps = {
          normal = {
            # "<leader>pf" = {action = ":Telescope find_files<CR>";};
            # "<leader>p" = {action = "\"_dP";};
            "<leader>y" = {action = "\"+y";};
            "<leader>u" = {action = ":UndotreeToggle<CR>";};
            "<leader>f" = {action = ":lua vim.lsp.buf.format()<CR>";};
            "<leader>d" = {action = "\"_d";};
            # "<leader>a" = ":lua require(\"harpoon.mark\").add_file()<CR>";
            # "<leader>q" = ":lua require(\"harpoon.ui\").toggle_quick_menu()<CR>";
            "<leader>pv" = {action = ":E<CR>";};
            "<leader>q" = {action = ":lua require('harpoon'):list():append()<CR>";};
          };
          visual = {
            "<leader>y" = {action = "\"+y";};
            "<leader>p" = {action = "\"_dP";};
            "<leader>d" = {action = "\"_d";};
          };
        };
      };
    };
  };
}
