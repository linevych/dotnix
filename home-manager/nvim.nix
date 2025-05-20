{ ... }:
{
  programs.nixvim = {

    enable = true;
    opts = {
      number = true;
      relativenumber = true;
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
  };
}
