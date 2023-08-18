{ pkgs, ... }: {

  gtk = {
    enable = true;
    theme = {
      name = "Orchis-Dark-Compact";
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  dconf.settings = {

    "system/locale/org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Orchis-Dark-Compact";
      cursor-theme = "Adwaita";
      icon-theme = "Adwaita";
    };

    "system/locale/org/gnome/shell/extensions/user-theme" = {
      name = "Orchis-Dark-Compact";
    };

    "system/locale/org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-d.svg";
      primary-color = "#241f31";
      secondary-color = "#000000";
    };
    "system/locale/org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/blobs-l.svg";
      primary-color = "#241f31";
      secondary-color = "#000000";
    };
  };
  home.sessionVariables.GTK_THEME = "Orchis-Dark-Compact";
  home.packages = with pkgs; [
    orchis-theme
  ];
}
