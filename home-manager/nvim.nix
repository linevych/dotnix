{ ... }:
{
  programs.nixvim = {

    enable = true;
    opts = {
      number = true;
      relativenumber = true;
    };
    globals = {
      "mapleader" = " ";
      "maplocalleader" = " ";
    };

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
        pylsp.enable = true;
        nil_ls = {
          enable = true;
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
            staticcheck = true;
            analyses = {
              unusedparams = true;
              shadow = true;
            };
          };
        };
      };
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
        "<C-space>" = "cmp.mapping.complete()";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
    };

    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>fd" = "find_files";
        "<leader>fb" = "buffers";
      };
    };
  };
}
