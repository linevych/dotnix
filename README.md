# README

Rebuild the system:

```bash
sudo nixos-rebuild switch --flake .#devBox
```

Rebuild home:
```bash
home-manager switch --flake .#anton@devBox
```

Wallpaper credit to: https://github.com/NixOS/nixos-artwork/