{ pkgs, inputs,... }:

{
  home.packages = with pkgs; [
    vscode
    micro
    lsof
    nodejs
    mariadb
    nix-sweep
    gdu

    python313
    ruff
		ty
		uv

    gnumake
    cpplint
    clang-tools


    chromium

    btop
    tree
    tldr
    diff-so-fancy

    spotify
    vesktop
    bitwarden-desktop
    telegram-desktop
    ghostty
    freetube

    texliveFull
    pandoc
  ];
}
