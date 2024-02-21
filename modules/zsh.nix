{ pkgs, config, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = [
      "main"
      "brackets"
      "pattern"
      "root"
      "line"
    ];
  };
}
