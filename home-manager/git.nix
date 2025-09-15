{ ... }:

{
  programs.git = {
    enable = true;
    userName = "linevych";
    userEmail = "anton@linevich.net";
    extraConfig = {
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };
}
