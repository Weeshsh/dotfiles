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

    vivaldi
    spotify
    vesktop
    bitwarden-desktop
    telegram-desktop
    ghostty

    texliveFull
  ];
}
