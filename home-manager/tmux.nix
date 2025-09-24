{
  pkgs,
  config,
  ...
}:
let
  conf = "${config.xdg.configHome}/tmux/tmux.conf";
in
{
  programs.tmux = {
    enable = true;
    prefix = "C-Space";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      catppuccin
      yank
    ];

    extraConfig = ''
      # Keybinding
      bind | split-window -h
      bind r source-file ${conf} \; display "Reloaded!"
                  
      # Theme
      set -g @catppuccin_flavour '${config.catppuccin.flavor}'

      # Sensible indexing for windows and panes
      set -g base-index 1
      set -g pane-base-index 1
       
      # TODO: copy mode enter is Leader + [ which is cumbersome, remap to something 
      set-window-option -g mode-keys vi 
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    '';
  };
}
