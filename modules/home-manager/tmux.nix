{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.tmux;
in
{
  options.modules.tmux = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable
    {
      programs = {
        tmux = {
          enable = true;
          shortcut = "space";
          clock24 = true;
          keyMode = "vi";
          mouse = true;

          plugins = with pkgs; [
            {
              plugin = tmuxPlugins.resurrect;
              extraConfig = "set -g @resurrect-strategy-nvim 'session'";
            }
            {
              plugin = tmuxPlugins.continuum;
            }
            tmuxPlugins.vim-tmux-navigator
            tmuxPlugins.catppuccin
            tmuxPlugins.yank
          ];

          extraConfig = ''
            set-option -sg escape-time 10

            # Use 256 colors
            set -g default-terminal "tmux-256color"
            set -ag terminal-overrides ",xterm-256color:RGB"
      
            # Vim style pane selection
            bind h select-pane -L
            bind j select-pane -D 
            bind k select-pane -U
            bind l select-pane -R

            # Start windows and panes at 1, not 0
            set -g base-index 1
            set -g pane-base-index 1
            set-window-option -g pane-base-index 1
            set-option -g renumber-windows on

            # Use Alt-arrow keys without prefix key to switch panes
            bind -n M-Left select-pane -L
            bind -n M-Right select-pane -R
            bind -n M-Up select-pane -U
            bind -n M-Down select-pane -D

            # Shift arrow to switch windows
            bind -n S-Left  previous-window
            bind -n S-Right next-window

            # Shift Alt vim keys to switch windows
            bind -n M-H previous-window
            bind -n M-L next-window

            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
            bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

            bind '"' split-window -v -c "#{pane_current_path}"
            bind % split-window -h -c "#{pane_current_path}"
          '';
        };
      };
    };
}
