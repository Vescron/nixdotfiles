# My personal nix-os config files  
![](https://github.com/Vescron/nixdotfiles/blob/main/Images/Screenshot%20From%202025-05-11%2018-11-12.png)
## To replicate the config:
1. Clone the repo
   ```
   git clone https://github.com/Vescron/nixdotfiles/
   ```
3. I keep the dotfiles in .config
   ```
   mv nixdotfiles ~/.config/dotfiles
   ```
4. Copy the autogenerated hardware config
   ```
   cp /etc/nixos/hardware-configuration.nix ~/.config/dotfiles/
   ```
   
5. Finally rebuild and switch
   ```
   cd ~/.config/dotfiles
   sudo nixos-rebuild switch --flake .#sibtain
   ```
