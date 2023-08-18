{ pkgs, ... }: {
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "Move_Clock@rmy.pobox.com"
        "always-indicator@martin.zurowietz.de"
        "dash-to-panel@jderose9.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "caffeine@patapon.info"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "tiling-assistant@leleat-on-github"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];
    };
    "system/locale/org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 2;
      nightlight-control = "always";
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover = false;
      animate-appicon-hover-animation-extent = "{'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}";
      appicon-margin = 4;
      appicon-padding = 4;
      available-monitors = [ 0 ];
      click-action = "CYCLE-MIN";
      desktop-line-custom-color = "rgb(246,97,81)";
      desktop-line-use-custom-color = true;
      dot-position = "BOTTOM";
      dot-style-focused = "DOTS";
      dot-style-unfocused = "DOTS";
      hotkeys-overlay-combo = "TEMPORARILY";
      leftbox-padding = -1;
      middle-click-action = "LAUNCH";
      panel-anchors = ''
        {"0":"MIDDLE"}
      '';
      panel-element-positions = ''
        {"0":[{"element":"showAppsButton","visible":true,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}
      '';
      panel-lengths = ''
        {"0":100}
      '';
      panel-positions = ''
        {"0":"TOP"}
      '';
      panel-sizes = ''
        {"0":32}
      '';
      primary-monitor = 0;
      shift-click-action = "TOGGLE-SHOWPREVIEW";
      shift-middle-click-action = "LAUNCH";
      show-apps-icon-file = "";
      show-apps-icon-side-padding = 10;
      show-showdesktop-hover = true;
      showdesktop-button-width = 30;
      status-icon-padding = -1;
      trans-bg-color = "#99c1f1";
      trans-use-custom-bg = false;
      trans-use-custom-gradient = false;
      trans-use-custom-opacity = true;
      trans-use-dynamic-opacity = true;
      tray-padding = -1;
      window-preview-size = 200;
      window-preview-title-position = "TOP";
    };

  };
  home.packages = with pkgs.gnomeExtensions; [
    user-themes
    native-window-placement
    auto-move-windows
    appindicator
    always-indicator
    caffeine
    move-clock
    tiling-assistant
    dash-to-panel
  ];
}
