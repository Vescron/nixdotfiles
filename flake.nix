{
  description = "Home Manager configuration of sibtain";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    catppuccin = {
      url = "github:catppuccin/nix";
    };

    curd = {
            url = "github:Wraient/curd";
            inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, catppuccin, home-manager, ... } @ inputs: 
    let
      # system = "x86_64-linux";
      pkgs = import nixpkgs {system="x86_64-linux"; config.allowUnfree = true;
                          overlays = [inputs.alacritty-theme.overlays.default];};
      inherit (self) outputs;
    in {

      nixosConfigurations = {
      sibtain = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [./configuration.nix];
        };
      };
      
      homeConfigurations."sibtain" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Use the system's Nixpkgs for the Home Manager configuration.

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [ ./Home-manager/home.nix
          inputs.zen-browser.homeModules.twilight
          catppuccin.homeModules.catppuccin
          inputs.spicetify-nix.homeManagerModules.default ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
