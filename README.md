# README

This is config that I use on NixOS and on Mac (Nix-Darwin) you can use it as an example to build your own.

Rebuild the system:

```bash
sudo nixos-rebuild switch --flake .#devBox
```

Rebuild home:
```bash
home-manager switch --flake .#anton@devBox
```

Wallpaper credit to: https://github.com/NixOS/nixos-artwork/
