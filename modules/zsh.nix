{ pkgs, config, lib, ... }: {
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.syntaxHighlighting.highlighters = [
    "main"
    "brackets"
    "pattern"
    "root"
    "line"
  ];
}
