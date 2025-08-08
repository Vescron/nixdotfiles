{
  config,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
    brillo = spawn "${pkgs.brillo}/bin/brillo" "-q" "-u" "300000";
    playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
  in {
    "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

    "XF86AudioPlay".action = playerctl "play-pause";
    "XF86AudioStop".action = playerctl "pause";
    "XF86AudioPrev".action = playerctl "previous";
    "XF86AudioNext".action = playerctl "next";

    "XF86AudioRaiseVolume".action = set-volume "5%+";
    "XF86AudioLowerVolume".action = set-volume "5%-";

    "XF86MonBrightnessUp".action = brillo "-A" "5";
    "XF86MonBrightnessDown".action = brillo "-U" "5";

    "Mod+Shift+Alt+S".action = screenshot-window;
    "Mod+Shift+S".action.screenshot = {show-pointer = false;};
    "Mod+L".action = spawn "qs" "ipc" "-p" "/home/sibtain/.config/dotfiles/Noctalia" "call" "globalIPC" "toggleLock";

    "Mod+Shift+Slash".action.show-hotkey-overlay = {};

    # Applications - Fix spawn syntax
    "Mod+Return".action.spawn = "alacritty";
    "Mod+R".action = spawn "qs" "ipc" "-p" "/home/sibtain/.config/dotfiles/Noctalia" "call" "globalIPC" "toggleLauncher";

    # Window management
    "Mod+Q".action.close-window = {};
    "Mod+left".action.focus-column-left = {};
    "Mod+right".action.focus-column-right = {};
    "Mod+down".action.focus-window-down = {};
    "Mod+up".action.focus-window-up = {};
    "Mod+A".action.focus-column-left = {};
    "Mod+D".action.focus-column-right = {};
    "Mod+S".action.focus-window-down = {};
    "Mod+W".action.focus-window-up = {};

    "Mod+Ctrl+A".action.move-column-left = {};
    "Mod+Ctrl+D".action.move-column-right = {};
    "Mod+Ctrl+S".action.move-window-down = {};
    "Mod+Ctrl+W".action.move-window-up = {};

    # Workspace switching
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;

    "Mod+Ctrl+1".action.move-column-to-workspace = 1;
    "Mod+Ctrl+2".action.move-column-to-workspace = 2;
    "Mod+Ctrl+3".action.move-column-to-workspace = 3;
    "Mod+Ctrl+4".action.move-column-to-workspace = 4;

    # Column management
    "Mod+T".action.switch-preset-column-width = {};
    "Mod+F".action.maximize-column = {};
    "Mod+Shift+F".action.fullscreen-window = {};
    "Mod+Shift+V".action.toggle-window-floating = {};

    "ALT+Tab".action.toggle-overview = {};

    # Screenshots
    "Print".action.screenshot = {};

    # System
    "Mod+Shift+E".action.quit = {};

    #Applications
    "Mod+E".action.spawn = "nautilus";
    "Mod+B".action.spawn = "zen-twilight";
    "Mod+C".action.spawn = "code";
  };
}
