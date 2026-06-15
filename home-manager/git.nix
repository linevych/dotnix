{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "linevych";
        email = "anton@linevich.net";
      };
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };
}
