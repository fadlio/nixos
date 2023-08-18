{
  dconf.settings = {
    "system/locale/org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      maximize = [ ];
      unmaximize = [ ];
    };
    "system/locale/org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
      help = [ ];
      home = [ "<Super>e" ];
      screensaver = [ ];
    };

    "system/locale/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Alacritty";
    };
  };
}
