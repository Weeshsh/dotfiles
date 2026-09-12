{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
    micro
    gnumake
    lsof
    nodejs
    ruff
    uv
    cpplint
    mariadb

    btop
    gdu
    tree
    tldr
    diff-so-fancy

    firefox
    vivaldi
    spotify
    vesktop
    bitwarden-desktop
    telegram-desktop
    ghostty

    texliveFull

    # (texlive.combine {
    #   inherit (texlive)
    #     scheme-basic
    #     collection-langpolish
    #     collection-latexrecommended
    #     collection-pictures
    #     beamer
    #     collection-latexextra
    #     ;
    # })
  ];
}
