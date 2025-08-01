{ config, pkgs, inputs, ... }:

{
  imports = [
    # Include the Home Manager module
    ./niri
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sibtain";
  home.homeDirectory = "/home/sibtain";
  
  programs.git = {
    enable = true;
    userName  = "Vescron";
    userEmail = "sibtaingeri@outlook.com";
    extraConfig = {
      safe = {
        directory = ["/run/media/sibtain/Windows/Users/Sibtain/amadeus"
                     "/run/media/sibtain/Local Disk/Vescron.github.io"
      ];
      };
    };
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
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.user-themes
    pkgs.gnomeExtensions.open-bar
    pkgs.qbittorrent
    pkgs.miru
    pkgs.heroic
    pkgs.wasistlos
    pkgs.resources
    inputs.curd.packages.${pkgs.system}.default
    pkgs.fakeroot
    pkgs.unzip
    pkgs.pciutils
    pkgs.termius
    pkgs.tokyonight-gtk-theme
    pkgs.mako
    pkgs.fuzzel
    pkgs.base16-schemes
    pkgs.papirus-icon-theme   # Add this line
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-gnome
    pkgs.kdePackages.polkit-kde-agent-1
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.font-awesome
    pkgs.swaybg
    pkgs.xwayland-satellite
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

    ".local/share/applications/code.desktop".text = ''
      [Desktop Entry]
      Name=Visual Studio Code
      Comment=Code Editing. Redefined.
      GenericName=Text Editor
      Exec=env ELECTRON_OZONE_PLATFORM_HINT=wayland code --ozone-platform=wayland %F
      Icon=vscode
      Type=Application
      StartupNotify=true
      Categories=Utility;TextEditor;Development;IDE;
      MimeType=text/plain;inode/directory;
      Actions=new-window;
      StartupWMClass=code

      [Desktop Action new-window]
      Name=New Window
      Exec=env ELECTRON_OZONE_PLATFORM_HINT=wayland code --ozone-platform=wayland --new-window %F
      Icon=vscode
    '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
    # MANGOHUD=1;
    WAYLAND_DISPLAY="wayland-1";
    XDG_SESSION_TYPE="wayland";
    XDG_CURRENT_DESKTOP="niri";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    
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
    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "blur-my-shell@aunetx"
        "open-bar@linuxfactory.org"
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
    # settings.window.decorations = "none";
    settings.general.import = [pkgs.alacritty-theme.tokyo_night];
  };
  
  # catppuccin.flavor = "mocha";
  # # catppuccin.starship.enable = true;
  # catppuccin.accent = "mauve";
  # catppuccin.enable = true;
  # catppuccin.gtk.enable = true;
  # catppuccin.gtk.gnomeShellTheme = true;
  # catppuccin.gtk.icon.enable = true;
  # catppuccin.gtk.icon.accent = "mauve";
  # catppuccin.gtk.accent = "mauve";
  # catppuccin.gtk.tweaks = ["float"];
  # catppuccin.gtk.icon.flavor = "mocha";
  gtk = {
    # Enable GTK applications to use the system theme.
    enable = true;
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Classic";

    # theme = {
    #   package = pkgs.tokyonight-gtk-theme;
    #   name = "Tokyonight-Dark";
    # };

    iconTheme = {
      package = pkgs.papirus-icon-theme; 
      name = "Papirus-Dark";              
    };
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

stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    targets = {
      spicetify.enable = false;
      gnome.enable = false;
      zen-browser.enable = false;
    };
    # fonts = {
    #   monospace = "JetBrainsMono Nerd Font";
    #   sansSerif = "Inter";
    # };
    # image = ./wallpapers/moonlight.png;
  };

programs.waybar.enable = true;

#  programs.niri = {
#   settings = {
#     # Input configuration
#     input = {
#       keyboard = {
#         xkb = {
#           layout = "us";
#           # variant = "";  # Remove empty strings
#           # model = "";
#           # options = "";
#         };
#         repeat-delay = 600;
#         repeat-rate = 25;
#         track-layout = "global";
#       };
      
#       touchpad = {
#         tap = true;
#         dwt = true;
#         dwtp = true;
#         natural-scroll = false;
#         accel-speed = 0.0;
#         accel-profile = "adaptive";
#         tap-button-map = "left-right-middle";
#         disabled-on-external-mouse = false;
#       };
      
#       mouse = {
#         accel-speed = 0.0;
#         accel-profile = "adaptive";
#         natural-scroll = false;
#         left-handed = false;
#         middle-emulation = false;
#         scroll-method = "two-finger";
#       };

#       tablet = {
#         # map-to-output = "";  # Remove empty strings
#       };

#       touch = {
#         # map-to-output = "";  # Remove empty strings
#       };

#       warp-mouse-to-focus = false;
#       focus-follows-mouse = {
#         enable = false;
#       };
#     };

#     # Output configuration (monitors)
#     outputs = {
#       "eDP-1" = {
#         # enable = true;  # This option doesn't exist
#         mode = { width = 1920; height = 1080; refresh = 60.0; };  # Changed from resolution/refresh-rate
#         position = { x = 0; y = 0; };
#         transform = {
#           flipped = false;
#           rotation = 0;
#         };
#         scale = 1.0;
#       };
#     };

#     # Layout configuration
#     layout = {
#       gaps = 16;
#       center-focused-column = "never";
#       # always-center-single-column = false;  # This option doesn't exist
#       preset-column-widths = [
#         { proportion = 0.33333; }
#         { proportion = 0.5; }
#         { proportion = 0.66667; }
#       ];
#       default-column-width = { proportion = 0.5; };
#       focus-ring = {
#         enable = true;
#         width = 4;
#         active.color = "#7fc8ff";
#         inactive.color = "#505050";
#         # active-gradient = null;    # Remove null values
#         # inactive-gradient = null;
#       };
#       border = {
#         enable = false;
#         width = 4;
#         active.color = "#ffc87f";
#         inactive.color = "#505050";
#         # active-gradient = null;    # Remove null values
#         # inactive-gradient = null;
#       };
#       struts = {
#         left = 0;
#         right = 0;
#         top = 0;
#         bottom = 0;
#       };
#     };

#     # Window rules
#     window-rules = [
#       # Example:
#       # {
#       #   matches = [{ app-id = "firefox"; }];
#       #   default-column-width = { proportion = 0.75; };
#       # }
#     ];

#     # Keybindings - Fix the spawn actions
#     binds = {
#       "Mod+Shift+Slash".action.show-hotkey-overlay = {};

#       # Applications - Fix spawn syntax
#       "Mod+Return".action.spawn = "alacritty";
#       "Mod+R".action.spawn = "fuzzel";

#       # Window management
#       "Mod+Q".action.close-window = {};
#       "Mod+H".action.focus-column-left = {};
#       "Mod+L".action.focus-column-right = {};
#       "Mod+J".action.focus-window-down = {};
#       "Mod+K".action.focus-window-up = {};
#       "Mod+A".action.focus-column-left = {};
#       "Mod+D".action.focus-column-right = {};
#       "Mod+S".action.focus-window-down = {};
#       "Mod+W".action.focus-window-up = {};

#       "Mod+Ctrl+H".action.move-column-left = {};
#       "Mod+Ctrl+L".action.move-column-right = {};
#       "Mod+Ctrl+J".action.move-window-down = {};
#       "Mod+Ctrl+K".action.move-window-up = {};

#       # Workspace switching
#       "Mod+1".action.focus-workspace = 1;
#       "Mod+2".action.focus-workspace = 2;
#       "Mod+3".action.focus-workspace = 3;
#       "Mod+4".action.focus-workspace = 4;

#       "Mod+Ctrl+1".action.move-column-to-workspace = 1;
#       "Mod+Ctrl+2".action.move-column-to-workspace = 2;
#       "Mod+Ctrl+3".action.move-column-to-workspace = 3;
#       "Mod+Ctrl+4".action.move-column-to-workspace = 4;

#       # Column management
#       "Mod+T".action.switch-preset-column-width = {};
#       "Mod+F".action.maximize-column = {};
#       "Mod+Shift+F".action.fullscreen-window = {};

#       # Screenshots
#       "Print".action.screenshot = {};

#       # System
#       "Mod+Shift+E".action.quit = {};
#     };

#     # Startup applications - Fix spawn-at-startup syntax
#     spawn-at-startup = [
#       # { command = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"; }
#       { command = ["mako"]; }
#       { command = ["waybar"]; }
#       { command = ["swaybg" "--image" "/path/to/wallpaper.jpg"]; }
#       { command = ["xwayland-satellite"]; }
#     ];

#     # Screenshot configuration
#     screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

#     # Appearance
#     prefer-no-csd = true;
#     hotkey-overlay.skip-at-startup = false;

#     # Cursor configuration
#     cursor = {
#       size = 24;
#       theme = "Bibata-Modern-Classic";
#     };
#   };
# };
}

