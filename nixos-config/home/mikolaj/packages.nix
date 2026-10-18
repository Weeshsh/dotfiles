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
    stdenv.cc.cc.lib
    glib
    gcc
    cmake
    boost
    ninja
    clang-tools


    chromium

    btop
    tree
    tldr
    diff-so-fancy

    # inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    spotify
    vesktop
    bitwarden-desktop
    telegram-desktop
    ghostty
    freetube
    stretchly

    texliveFull
    pandoc
  ];
}
