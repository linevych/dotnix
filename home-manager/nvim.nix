{ ... }:
{
  programs.nixvim = {

    enable = true;
    opts = {
      number = true;
      relativenumber = true;
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
    ];

    colorschemes.catppuccin.enable = true;

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
        rust-analyzer.enable = true;
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
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fb" = "buffers";
      };
    };
    plugins.leap = {
      enable = true;
    };
  };
}
