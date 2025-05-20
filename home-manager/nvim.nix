{ ... }:
{
  home.packages = [
    nixvim
  ];
  nixvim = {
    enable = true;
  };
}
