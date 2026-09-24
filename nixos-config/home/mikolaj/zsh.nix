{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo"
        "aws"
      ];
    };

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    shellAliases = {
      ls = "ls --color";
      cat = "bat";
      nx-cg = "sudo nix-collect-garbage";
      nx-rs = "sudo nixos-rebuild switch --flake ~/nixos-config#nixoson_michael";
      nx-test = "sudo nixos-rebuild test --flake ~/nixos-config#nixoson_michael";
      nx-edit = "code ~/nixos-config";
      nx-optimise = "sudo nix store optimise";
      nx-update = "sudo nix flake update --flake ~/nixos-config";
      nx-refresh = "nx-update && nx-rs && nx-cg && nx-optimise";
    };

    history = {
      size = 5000;
      save = 5000;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      share = true;
    };

    initContent = ''
      source ${config.xdg.configHome}/p10k/p10k.zsh

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

      echo "Paula jest najsuper na świecie <3"
    '';
  };

  xdg.configFile."p10k/p10k.zsh".source = ./p10k.zsh;
}
