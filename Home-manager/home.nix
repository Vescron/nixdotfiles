{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sibtain";
  home.homeDirectory = "/home/sibtain";
  
  programs.git = {
    enable = true;
    userName  = "Vescron";
    userEmail = "sibtaingeri@outlook.com";
  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.gnome-tweaks
    pkgs.mangojuice
    pkgs.mangohud
    pkgs.git
    pkgs.rquickshare
    pkgs.dwarfs
    pkgs.fuse-overlayfs
    pkgs.wineWowPackages.staging
    pkgs.bubblewrap
    pkgs.cartridges
    pkgs.gnomeExtensions.appindicator
    pkgs.qbittorrent
    pkgs.miru
    pkgs.heroic
    pkgs.wl-clipboard
    pkgs.slurp
    pkgs.grim
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
    # MANGOHUD=1;
  };

  programs.mpv = {
  enable = true;

  package = (
    pkgs.mpv-unwrapped.wrapper {
      scripts = with pkgs.mpvScripts; [
        uosc
        sponsorblock
        thumbfast
        videoclip # c
        quality-menu
        mpv-discord #shift+d
        youtube-upnext #ctrl+u
      ];

      mpv = pkgs.mpv-unwrapped.override {
        waylandSupport = true;
      };
    }
  );

  config = {
    profile = "high-quality";
    ytdl-format = "bestvideo[height<=1440][vcodec^=avc1]+bestaudio";
    cache-default = 4000000;
  };
};

  programs.zsh = {
  enable = true;
  # enableCompletions = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  initContent = "source ~/.p10k.zsh";
  shellAliases = {
    # ll = "ls -l";
    nixupdate = "sudo nixos-rebuild switch --flake $HOME/.config/dotfiles/#sibtain";
    homeupdate = "home-manager switch --flake $HOME/.config/dotfiles/#sibtain";
  };
  history.size = 10000;
  plugins = [{                                                                                   
    name = "powerlevel10k";                                                           
    src = pkgs.zsh-powerlevel10k;                                                     
    file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";                         
  }];
  oh-my-zsh = {
    enable = true;
    plugins = [ "git"];
    custom = "$HOME/.oh-my-zsh/custom/";
    # theme = "powerlevel10k/powerlevel10k";
  };
};

  # Hyprland
  wayland.windowManager.hyprland = {
        enable = true;
        # catppuccin.enable = true;
        xwayland = {
          enable = true;
        };

        # package = inputs.hyprland.packages.${pkgs.system}.hyprland;

        settings = {
          "$terminal" = "kitty";
          "$mod" = "SUPER";

          monitor = [
            # "eDP-1, 1920x1080, 0x0, 1"
            ",prefered,auto,1"
          ];

          xwayland = {
            force_zero_scaling = true;
          };

          general = {
            gaps_in = 6;
            gaps_out = 6;
            border_size = 2;
            layout = "dwindle";
            allow_tearing = true;
          };

          input = {
            kb_layout = "us";
            follow_mouse = true;
            touchpad = {
              natural_scroll = true;
            };
            accel_profile = "flat";
            sensitivity = 0;
          };

          decoration = {
            rounding = 15;
            active_opacity = 0.9;
            inactive_opacity = 0.8;
            fullscreen_opacity = 0.9;

            blur = {
              enabled = true;
              xray = true;
              special = false;
              new_optimizations = true;
              size = 14;
              passes = 4;
              brightness = 1;
              noise = 0.01;
              contrast = 1;
              popups = true;
              popups_ignorealpha = 0.6;
              ignore_opacity = false;
            };

            drop_shadow = true;
            shadow_ignore_window = true;
            shadow_range = 20;
            shadow_offset = "0 2";
            shadow_render_power = 4;
          };

          animations = {
            enabled = true;
            bezier = [
              "linear, 0, 0, 1, 1"
              "md3_standard, 0.2, 0, 0, 1"
              "md3_decel, 0.05, 0.7, 0.1, 1"
              "md3_accel, 0.3, 0, 0.8, 0.15"
              "overshot, 0.05, 0.9, 0.1, 1.1"
              "crazyshot, 0.1, 1.5, 0.76, 0.92"
              "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
              "menu_decel, 0.1, 1, 0, 1"
              "menu_accel, 0.38, 0.04, 1, 0.07"
              "easeInOutCirc, 0.85, 0, 0.15, 1"
              "easeOutCirc, 0, 0.55, 0.45, 1"
              "easeOutExpo, 0.16, 1, 0.3, 1"
              "softAcDecel, 0.26, 0.26, 0.15, 1"
              "md2, 0.4, 0, 0.2, 1"
            ];
            animation = [
              "windows, 1, 3, md3_decel, popin 60%"
              "windowsIn, 1, 3, md3_decel, popin 60%"
              "windowsOut, 1, 3, md3_accel, popin 60%"
              "border, 1, 10, default"
              "fade, 1, 3, md3_decel"
              "layersIn, 1, 3, menu_decel, slide"
              "layersOut, 1, 1.6, menu_accel"
              "fadeLayersIn, 1, 2, menu_decel"
              "fadeLayersOut, 1, 4.5, menu_accel"
              "workspaces, 1, 7, menu_decel, slide"
              "specialWorkspace, 1, 3, md3_decel, slidevert"
            ];
          };

          cursor = {
            enable_hyprcursor = true;
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
            no_gaps_when_only = 0;
            smart_split = false;
            smart_resizing = false;
          };

          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
          };

          bind = [
            # General
            "$mod, return, exec, $terminal"
            "$mod SHIFT, q, killactive"
            "$mod SHIFT, e, exit"
            "$mod SHIFT, l, exec, ${pkgs.hyprlock}/bin/hyprlock"

            # Screen focus
            "$mod, v, togglefloating"
            "$mod, u, focusurgentorlast"
            "$mod, tab, focuscurrentorlast"
            "$mod, f, fullscreen"

            # Screen resize
            "$mod CTRL, h, resizeactive, -20 0"
            "$mod CTRL, l, resizeactive, 20 0"
            "$mod CTRL, k, resizeactive, 0 -20"
            "$mod CTRL, j, resizeactive, 0 20"

            # Workspaces
            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 10"

            # Move to workspaces
            "$mod SHIFT, 1, movetoworkspace,1"
            "$mod SHIFT, 2, movetoworkspace,2"
            "$mod SHIFT, 3, movetoworkspace,3"
            "$mod SHIFT, 4, movetoworkspace,4"
            "$mod SHIFT, 5, movetoworkspace,5"
            "$mod SHIFT, 6, movetoworkspace,6"
            "$mod SHIFT, 7, movetoworkspace,7"
            "$mod SHIFT, 8, movetoworkspace,8"
            "$mod SHIFT, 9, movetoworkspace,9"
            "$mod SHIFT, 0, movetoworkspace,10"

            # Navigation
            "$mod, h, movefocus, l"
            "$mod, l, movefocus, r"
            "$mod, k, movefocus, u"
            "$mod, j, movefocus, d"

            # Applications
            "$mod ALT, f, exec, ${pkgs.firefox}/bin/firefox"
            "$mod ALT, e, exec, $terminal --hold -e ${pkgs.yazi}/bin/yazi"
            "$mod ALT, o, exec, ${pkgs.obsidian}/bin/obsidian"
            "$mod, r, exec, pkill fuzzel || ${pkgs.fuzzel}/bin/fuzzel"
            "$mod ALT, r, exec, pkill anyrun || ${pkgs.anyrun}/bin/anyrun"
            "$mod ALT, n, exec, swaync-client -t -sw"

            # Clipboard
            "$mod ALT, v, exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy"

            # Screencapture
            "$mod, S, exec, ${pkgs.grim}/bin/grim | wl-copy"
            "$mod SHIFT+ALT, S, exec, ${pkgs.grim}/bin/grim -g \"$(slurp)\" - | ${pkgs.swappy}/bin/swappy -f -"
          ];

          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];

          env = [
            "NIXOS_OZONE_WL,1"
            "_JAVA_AWT_WM_NONREPARENTING,1"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            "QT_QPA_PLATFORM,wayland"
            "SDL_VIDEODRIVER,wayland"
            "GDK_BACKEND,wayland"
            "LIBVA_DRIVER_NAME,nvidia"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"
            "XDG_CURRENT_DESKTOP,Hyprland"
            "GBM_BACKEND,nvidia-drm"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          ];
          exec-once = [
            "${pkgs.hyprpaper}/bin/hyprpaper"
            "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
            "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"
            "eval $(gnome-keyring-daemon --start --components=secrets,ssh,gpg,pkcs11)"
            "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"
            "hash dbus-update-activation-environment 2>/dev/null"
            "export SSH_AUTH_SOCK"
            "${pkgs.plasma5Packages.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
          ];
        };
  };

  dconf.settings = {
    # # This is an example of how to set a dconf setting. You can find the
    # # available settings in the dconf editor.
    # "org/gnome/desktop/interface" = {
    #   "clock-show-seconds" = true;
    # };
    # "org/gnome/shell" = {
    #   enabledExtensions=[
    #   "dash-to-dock@micxgx.gmail.com"];
    # };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
      disabled-extensions = [];
    };

    "org/gnome/shell/keybindings" = {
      "switch-to-application-1" = [""];
      "switch-to-application-2" = [""];
      "switch-to-application-3" = [""];
      "switch-to-application-4" = [""];
      "switch-to-application-5" = [""];
      "switch-to-application-6" = [""];
      "switch-to-application-7" = [""];
      "switch-to-application-8" = [""];
      "switch-to-application-9" = [""];
      
    };

    "org/gnome/desktop/wm/keybindings" = {
      "switch-to-workspace-1" = ["<Super>1"];
      "switch-to-workspace-2" = ["<Super>2"];
      "switch-to-workspace-3" = ["<Super>3"];
      "switch-to-workspace-4" = ["<Super>4"];
      "move-to-workspace-1" = ["<Shift><Super>1"];
      "move-to-workspace-2" = ["<Shift><Super>2"];
      "move-to-workspace-3" = ["<Shift><Super>3"];
      "move-to-workspace-4" = ["<Shift><Super>4"];
      "switch-to-workspace-left" = ["<Super>w"];
      "switch-to-workspace-right" = ["<Super>s"];
    
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Launch Browser";
      command = "zen-twilight";
      binding = "<Super>b"; 
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Open Files";
      command = "nautilus";
      binding = "<Super>e";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Open Terminal";
      command = "alacritty";
      binding = "<Super>Return";
    };
    
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.alacritty = {
    enable = true;
    settings.general.import = [pkgs.alacritty-theme.tokyo_night];
    
  };
  
  catppuccin.flavor = "mocha";
  # catppuccin.starship.enable = true;
  catppuccin.accent = "mauve";
  catppuccin.enable = true;
  catppuccin.gtk.enable = true;
  catppuccin.gtk.gnomeShellTheme = true;
  catppuccin.gtk.icon.enable = true;
  catppuccin.gtk.icon.accent = "mauve";
  catppuccin.gtk.accent = "mauve";
  catppuccin.gtk.tweaks = ["float"];
  catppuccin.gtk.icon.flavor = "mocha";
  gtk = {
    # Enable GTK applications to use the system theme.
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Classic";

    # Set the GTK theme to use. You can find a list of available themes in
    # /usr/share/themes.
    # theme = "Mint-Y";

    # Set the icon theme to use. You can find a list of available themes in
    # /usr/share/icons.
    # iconTheme.package = pkgs.catppuccin-papirus-folders.override{
    #   flavor = "mocha";
    #   accent = "lavender";
    # };
    # iconTheme.name = "Papirus-Dark";
  };

#Spicetify module
programs.spicetify =
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  enable = true;

  enabledExtensions = with spicePkgs.extensions; [
    adblock
    hidePodcasts
    shuffle # shuffle+ (special characters are sanitized out of extension names)
  ];
  enabledCustomApps = with spicePkgs.apps; [
    newReleases
    ncsVisualizer
  ];
  enabledSnippets = with spicePkgs.snippets; [
    rotatingCoverart
    pointer
  ];

  theme = spicePkgs.themes.catppuccin;
  colorScheme = "mocha";
};

programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };
}
