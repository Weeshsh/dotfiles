{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Mikołaj Wiszniewski";
        email = "mikowisz@gmail.com";
      };

      core = {
        sshCommand = "ssh";
        autocrlf = false;
      };

      merge = {
        ff = false;
        renameLimit = 100000;
      };

      pull.rebase = true;

      alias = {
        lg = "!git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset) %C(auto)%d%C(reset)'";
        s = "status";
        ss = "status --short";
        sw = "switch";
        undo = "reset HEAD~1 --mixed";
        d = "!git diff @{u} | diff-so-fancy | less --tabs=4 -RF";
        clear = "!git stash && git stash clear";
        p = "push";
      };

      color = {
        ui = true;

        "diff-highlight" = {
          oldNormal = "red bold";
          oldHighlight = "red bold 52";
          newNormal = "green bold";
          newHighlight = "green bold 22";
        };

        diff = {
          meta = "11";
          frag = "magenta bold";
          func = "146 bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
      };
    };
  };
}
