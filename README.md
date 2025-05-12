# My personal nix-os config files
## To replicate the config:
1. Clone the repo
   ```
   git clone https://github.com/Vescron/nixdotfiles/
   ```
3. I keep the dotfiles in .config
   ```
   mv nixdotfiles ~/.config/
   ```
4. Edit flake.nix and add ur own username in place of "sibtain"
   
5. Finally rebuild and switch
   ```
   cd ~/.config/dotfiles
   sudo nixos-rebuild switch --flake .#{your username}
   ```
