{ pkgs, inputs,... }:

{
  home.packages = with pkgs; [
    #vscode
    (vscode.overrideAttrs (old: {
      # VS Code 1.144 moved ripgrep; remove once nixpkgs uses the new path.
      postPatch = builtins.replaceStrings
        [ "@vscode/ripgrep/bin/rg" ]
        [ "@vscode/ripgrep-universal/bin/linux-x64/rg" ]
        (old.postPatch or "");
    }))
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

    # codex

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
    # stretchly

    texliveFull
    pandoc
  ];
}
