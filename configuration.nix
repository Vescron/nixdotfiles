# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nbfc.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  #boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.extraEntries = ''
  menuentry 'Windows Boot Manager (on /dev/sda5)' --class windows --class os $menuentry_id_option 'osprober-efi-3736-D347' {
    insmod part_gpt
    insmod fat
    set root='hd0,gpt5'
    if [ x$feature_platform_search_hint = xy ]; then
      search --no-floppy --fs-uuid --set=root --hint-ieee1275='ieee1275//disk@0,gpt5' --hint-bios=hd0,gpt5 --hint-efi=hd0,gpt5 --hint-baremetal=ahci0,gpt5  3736-D347
    else
      search --no-floppy --fs-uuid --set=root 3736-D347
    fi
    chainloader /efi/Microsoft/Boot/bootmgfw.efi
    }
  menuentry 'Void Linux (on /dev/sda4)' --class void --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-90b717f6-661b-424e-b45b-7ede77805151' {
    insmod part_gpt
    insmod ext2
    set root='hd0,gpt4'
    if [ x$feature_platform_search_hint = xy ]; then
      search --no-floppy --fs-uuid --set=root --hint-ieee1275='ieee1275//disk@0,gpt4' --hint-bios=hd0,gpt4 --hint-efi=hd0,gpt4 --hint-baremetal=ahci0,gpt4  90b717f6-661b-424e-b45b-7ede77805151
    else
      search --no-floppy --fs-uuid --set=root 90b717f6-661b-424e-b45b-7ede77805151
    fi
    linux /boot/vmlinuz-6.1.7_1 root=UUID=90b717f6-661b-424e-b45b-7ede77805151 ro loglevel=4
    initrd /boot/initramfs-6.1.7_1.img
  }
'';
  boot.loader.grub.theme = (pkgs.sleek-grub-theme.override {
	withBanner = "Grub";
	withStyle = "bigSur";
});
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  nix.settings.nix-path = config.nix.nixPath;
  nix.channel.enable = false;

  nix = {
    nixPath = [
      "nixpkgs=${pkgs.path}"
      "nixos-config=/home/sibtain/.config/dotfiles/configuration.nix"
    ];
  };

services.power-profiles-daemon.enable = false;

services.auto-cpufreq.enable = true;
services.auto-cpufreq.settings = {
  battery = {
     governor = "ondemand";
     turbo = "never";
  };
  charger = {
     governor = "performance";
     turbo = "auto";
  };
};

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.desktopManager.cinnamon.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    geary # email reader
    gnome-characters
    gnome-calendar
    gnome-contacts
    gnome-weather
    gnome-connections
    gnome-maps
    gnome-music
    gnome-terminal
    gnome-tour
    hitori # sudoku game
    iagno # go game
    simple-scan
    tali # poker game
    totem # video player
    yelp # help browser
  ]);

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sibtain = {
    isNormalUser = true;
    description = "Sibtain";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    vscode
    vesktop
    gimp
    kdePackages.filelight
    mpv
    steam
    spotify
    corectrl
    sleek-grub-theme
    btop
    cava
    alacritty
    python312
    python312Packages.pip
    pipx
    home-manager
    obs-studio
    neofetch
    flameshot
    obsidian
    nbfc-linux
    # catppuccin-papirus-folders
];

fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-emoji
];

hardware.graphics = {
  enable = true;
  enable32Bit = true;
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11"; # Did you read the comment?

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

}
