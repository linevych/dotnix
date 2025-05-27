{ ... }:
{
  programs.nixvim = {

    enable = true;
    opts = {
      number = true;
      colorcolumn = "120";
      tabstop = 4;
      shiftwidth = 4;
    };
    globals = {
      "mapleader" = " ";
      "maplocalleader" = " ";
    };
    keymaps = [
      {
        action = "<cmd>:w<cr>";
        mode = [ "n" ];
        key = "<leader>fs";
      }
      # Window manipulation
      {
        action = "<cmd>:vsplit<cr>";
        mode = [ "n" ];
        key = "<leader>w/";
      }
      {
        action = "<cmd>:split<cr>";
        mode = [ "n" ];
        key = "<leader>w\\";
      }
      {
        action = "<cmd>:close<cr>";
        mode = [ "n" ];
        key = "<leader>wd";
      }
      {
        action = "<cmd>:only<cr>";
        mode = [ "n" ];
        key = "<leader>wD";
      }
    ];

    colorschemes = {
      catppuccin = {
        enable = true;
        settings = {
          flavour = "macchiato";
        };
      };
    };

    plugins.lualine.enable = true;

    plugins.treesitter = {
      enable = true;
      nixvimInjections = true;
      # folding = true;

      settings = {
        ident.enable = true;
        auto_install = true;
        highlight.enable = true;
      };
    };

    plugins.lsp = {
      enable = true;

      servers = {
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        lua_ls.enable = true;

        pylsp = {
          enable = true;
          settings = {
            plugins = {
              black.enable = true;
            };
          };
        };

        # Support for Nix configs
        nil_ls = {
          enable = true;
          settings = {
            formatting = {
              command = [ "nixfmt" ];
            };

          };
        };
        gopls = {
          enable = true;
          filetypes = [
            "go"
            "gomod"
            "gowork"
            "gotmpl"
          ];
          settings = {
            matcher = "fuzzy";
            completeUnimported = true;
            usedPlaceholers = true;
            completeFunctionCalls = true;
            oragnizeImports = true;
            staticcheck = true;
            analyses = {
              unusedparams = true;
              shadow = true;
            };
            gofumpt = true;
          };
        };
      };

    };
    plugins.lsp-format = {
      enable = true;
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
      settings.mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<CR>" = "cmp.mapping.confirm({select = true})";
      };
    };

    plugins.telescope = {
      enable = true;
      extensions = {
        file-browser = {
          enable = true;
          settings = {
            hijack_netrw = true;
          };
        };

      };
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fb" = "buffers";
        "<leader>fd" = "file_browser";

      };
    };
    # Fancy icons, dependency for telescope
    plugins.web-devicons = {
      enable = true;
    };

    plugins.leap = {
      enable = true;
    };
    plugins.gitsigns = {
      enable = true;
    };
  };
}
