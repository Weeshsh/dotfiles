{ pkgs, inputs,... }:

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

    opencode

    btop
    gdu
    tree
    tldr
    diff-so-fancy

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    spotify
    vesktop
    bitwarden-desktop
    telegram-desktop
    ghostty

    texliveFull
    pandoc

  ];
}
