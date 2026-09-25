{ ... }:

{
  imports = [
    ./packages.nix
    ./git.nix
    ./zsh.nix
    ./hermes.nix
  ];

  home.username = "mikolaj";
  home.homeDirectory = "/home/mikolaj";

  xdg.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;
  programs.tmux.enable = true;

  home.stateVersion = "26.05";
}
