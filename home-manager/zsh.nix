{ ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "sudo"
        "thefuck"
        "docker"
        "docker-compose"
      ];
    };
    envExtra = ''DEFAULT_USER=anton''; # TODO: Remove hardcoded value
  };
}
