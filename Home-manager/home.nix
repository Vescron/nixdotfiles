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
    pkgs.lutris
    pkgs.gnomeExtensions.appindicator
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
    MANGOHUD=1;
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
