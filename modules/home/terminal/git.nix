{ pkgs
, lib
, custom
, secrets
, ...
}: {
  programs.git = {
    inherit (secrets.git.drmikecrowe) userName userEmail;
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    aliases = {
      aic = "git diff | sgpt 'Generate git commit message, for my changes' > /tmp/gitmsg && git commit -F /tmp/gitmsg";
      b = "branch";
      bc = "checkout -b";
      bl = "branch -v";
      bx = "branch -D";
      bm = "branch -M";
      bs = "show-branch -a";
      co = "checkout";
      co0 = "checkout HEAD --";
      f = "fetch";
      fap = "fetch --all --prune";
      fm = "pull";
      fo = "fetch origin";
      m = "merge";
      momn = "merge origin/main";
      mom = "merge origin/master";
      p = "push";
      pa = "push --all";
      pt = "push --tags";
      pnv = "push --no-verify";
      r = "rebase";
      ra = "rebase --abort";
      rc = "rebase --continue";
      ri = "rebase --interactive";
      rs = "rebase --skip";
      rom = "rebase origin/master";
      c = "commit -v";
      ca = "commit --all -v";
      cm = "commit --message";
      cam = "commit --all --message";
      camend = "commit --amend --reuse-message HEAD";
      cundo = "reset --soft HEAD^";
      cp = "cherry-pick";
      d = "diff";
      ds = "diff --staged";
      dc = "diff --staged";
      dh = "diff HEAD";
      hub = "browse";
      hubd = "compare";
      s = "status";
      a = "add";
      ia = "add";
      ir = "reset";
      l = "log --topo-order --pretty=format:'%C(yellow)%h %C(cyan)%cn %C(blue)%cr%C(reset) %s'";
      ls = "log --topo-order --stat --pretty=format:'%C(bold)%C(yellow)Commit:%C(reset) %C(yellow)%H%C(red)%d%n%C(bold)%C(yellow)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)%C(yellow)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'";
      ld = "log --topo-order --stat --patch --full-diff --pretty=format:'%C(bold)%C(yellow)Commit:%C(reset) %C(yellow)%H%C(red)%d%n%C(bold)%C(yellow)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)%C(yellow)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      lga = "log --topo-order --all --graph --pretty=format:'%C(yellow)%h %C(cyan)%cn%C(reset) %s %C(red)%d%C(reset)%n'";
      lm = "log --topo-order --pretty=format:'%s'";
      lh = "shortlog --summary --numbered";
      llf = "fsck --lost-found";
      lg1 = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
      test-merge = "merge --no-commit --no-ff";
      re = "remote";
      rel = "remote --verbose";
      rea = "remote add";
      rex = "remote rm";
      rem = "remote rename";
      grep = ''log --pretty="format:%Cgreen%H %Cblue%s" --name-status --grep'';
      safereset = ''
        !f() { 	trap 'echo ERROR: Operation failed; return' ERR; 	echo Making sure there are no changes...; 	last_status=$(git status --porcelain);	if [[ $last_status != "" ]]; then	echo There are dirty files:;echo "$last_status";	echo;	echo -n "Enter D if you would like to DISCARD these changes or W to commit them as WIP: ";	read dirty_operation;	if [ "$dirty_operation" == "D" ]; then 	echo Resetting...;	git reset --hard;	elif [ "$dirty_operation" == "W" ]; then	echo Comitting WIP...;	git commit -a --message='WIP' > /dev/null && echo WIP Comitted;	else	echo Operation cancelled;	exit 1;	fi;	fi;	}; 	f'';
      rename = "!f() { git branch -m $1 $2; git push origin :$1; git push --set-upstream origin $2; }; f";
      unpushed-branches = "!git log --branches --not --remotes --no-walk --decorate --oneline";
      archive-branch = "! f() { git tag archive/$1 $1 && git branch -D $1;}; f";
      head = "log -n1";
      heads = "!git log origin/master.. --format='%Cred%h%Creset;%C(yellow)%an%Creset;%H;%Cblue%f%Creset' | git name-rev --stdin --always --name-only | column -t -s';'";
      lost = "!git fsck | awk '/dangling commit/ {print $3}' | git show --format='SHA1: %C(yellow)%h%Creset %f' --stdin | awk '/SHA1/ {sub(\"SHA1: \", \"\"); print}'";
      missing-commits = "!git log -p --no-merges $1 ^develop";
      tomerge = ''
        !sh -c 'git branch -r --no-merged ''${2:-HEAD} | grep -Ev HEAD | grep -Ev "(\*|master|maint|next|proposed|demo-stable)" | grep ''${1:-.}' -'';
      aliases = "config --get-regexp ^alias\\.";
      longlog = "log --pretty=format:'%C(yellow)%h %C(cyan)%cn %C(blue)%cr%C(reset) %s' --graph";
      fuckit = "reset --hard";
      prune-branches = "!f() { git fetch --all --prune; git-delete-merged-branches --effort=3 --branch master; }; f";
    };

    ignores = [
      ".cache/"
      ".DS_Store"
      ".direnv/"
      ".venv"
      ".idea/"
      "*.swp"
      ".history"
      ".vscode/"
      "npm-debug.log"
    ];

    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
      };
      diff = { tool = "meld"; };
      difftool = {
        prompt = false;
        cmd = "meld $LOCAL $REMOTE";
      };
      merge = { tool = "meld"; };
      mergetool = {
        cmd = "meld $LOCAL $MERGED $REMOTE";
        keepBackup = false;
      };
      credential.helper = "store --file ~/.git-credentials";
      pull.rebase = "false";
      push.autoSetupRemote = "true";
      commit = {
        gpgsign = true;
      };
    };

    includes = [
      {
        contents = {
          user = {
            name = "Mike Crowe";
            email = "drmikecrowe@gmail.com";
            signingkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDoJdcvyJBhd9nLX1K/1cdC/5BBaxI6FpVBzME/RTtT42UGi/7KPp4PzbL1Qgj8HjtyzzlePCPEqlo0/N9zImBv50fojLfVwP8trv6SpYi1yVryzcFxLrGZzNd2SEfXu1K49rVqovRTplEI58lbk6wyOE71fZ8+zTdiJ7Hjgj6Zh1O1REi0v0FXJGqqIWezh4jA9vhuiO1KTyhYJ2lV8sw6JWNNwu767c/fRWaNxtpSS+lEgs57uWdoK8X+J3JkmBo2mvXQB4THYcQ07EsIwDhI9DD7N7xKAfnZNQ0fHMhO5NZWRfQh4xkvb4tXnMvDSwXbTR2lsNKRLJuyV29l5Pf0gL6PPHDlpVAYOpUjGF8d2/OyKElmDbEFrlD+Bh7K1t729vcmy3K/muveofUh6xrVyioFHs4fDp+QKKqNQTx9yLD5pe4t8sQAEIr4L7F68aLev92mCr8GgdpZV18xJ4XZLF0VvGUxj1qChpfzyQ+lI/79E1O5m5SxcZre6EX2PIbCbAwQEGTrCwr/+8xyH7CWx4EmtK7z9hmAINuvsMiHzi7g0n/nZJPmdF15cuzCGxnze1jCuxcDRk5r6glfKfcFfHXk3QUpROsbk8mtmYW9VwH4Fgz6c7Ar93dCHHoW52Z9nRVqf6Nd8zkt/ZIFJsVm44EzZP79LHXdhNv9NggDjQ==";
          };
          gpg = {
            format = "ssh";
            ssh = { program = "op-ssh-sign"; };
          };
          core = {
            sshCommand = "ssh -i ~/.ssh/id_rsa_drmikecrowe-github.pub";
          };
        };
        condition = "hasconfig:remote.*.url:git@github.com:drmikecrowe/*";
      }
      {
        contents = {
          user = {
            name = "Mike Crowe";
            email = "mike.crowe@mikkeltech.com";
            signingkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNCk0Q0fp4hHu8zU1Y5spTI2hZ60pYHQI92aOW09pUg5Gbh7XPO+mT/gPX00T9EX4IRWrNlfZj/zBWfVGmOoWXFdq9sV9C0INAGMldaaxF2RZ7xgqdb1h81UkmQmSasBU4qIJFNxIy7B2SPNZE89uIXSDBU71JwJfYOxxzNnKJjv84jJYhBADHiuV3JFuuxkxZo75wm9okKtRbbbvMj6Dt0GnsxzM9ZDFV2SaaFwTiSCYVmqmuJYKYGXNcMJIlQoT3c7mgDssflto+VJbnNGwXnxX13WmiE2/w83UjRSppvGGUnca0B4kCm+i+/vvV1Rvf3opIixghntReivQlE4P/NKTztEt6nHQ159UdQYDezumGnFO/uG+Q8wisy0Cg0eCEDbKO/kHAuyc5C1scVcXhftxgyEPDEMrLckFfebjhtP9z4courjK8/pirFyWXHhgezYYMBQ6LX3Ma+vNhkD97wvmbMRYEqXMfZodEJNygsoigZdr+jjRS/UUv445UXAGgamE85MLV/lVyWM1yGweY2PpEebKXg8oi3tYZAiB+iJsJxcLve0BFAavRF84cjvvTzkVrIgQRb6f2ErcE2J6OwPQQadGd5lC/HfyDl4DLWDIzEjLdNPMcJ9BWPNhjzoiLZOT3PQJv1HUaFCeGMbA8C7zy3+kxS+VnwPPjT58/Tw==";
          };
          gpg = {
            format = "ssh";
            ssh = { program = "op-ssh-sign"; };
          };
          core = { sshCommand = "ssh -i ~/.ssh/id_rsa_mikkel.pub"; };
        };
        condition = "hasconfig:remote.*.url:git@github.com:mikkeltech/*";
      }
      {
        contents = {
          user = {
            name = "Mike Crowe";
            email = "mike.crowe@pinnsg.com";
            signingkey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCe2RcKDoix4So+hT8Mr6gpas/gLfYId7Ab6mXSswRz8x2Tzg1ynNyUPXKER0vpsoVLs/CmTc9b0nJM/o2xJzrVxKIN/8Z4jqbM2bDmUFO0Hy4bVJnQnyj3vhMEOQS4UjdGVHVsGkeA/4mGg3hvCOG7TzCdVUd4OhK/zA+3vANQFhAzk6g5d6Ae6sp7WPU2CrTjGOkXB6+jRaRIOHtosQF9dCOp4FxBhT9AJBjZOBxkjMA9imf8CcczRmRwjSGHLy1feBdJCzWC+SZqgn1xCv4I/DdOxXvh8E41ttIFp4J2JFyk4anwOMWZvrg08UiUUOhaqKMB3eTM41YuEW/ls5FID25f6Ex9iG5Gw1cV9h2kZiRxJgCktrw3qIruFuGvFEobKOQctoYPoMRuqb482KFMeUk17mB9O7I4t5GKyyXDi8HhHLdwoytGhCzAO7RkYHUUGywh48D2NMkjvgFLTagERqZ45YU9OwrDM1JVUMXLPPmZvnxD977TK6g5L5WWjpEftm1dEqAUXv/GMNJzjIvGJPLehARpdYErcbvVftOupay3TRjmRahvAvXJ3rX9Ce2pyrOXaB1A2qqRlpuCDpiCxVpRWC088Q/XQs4qugCmcHM3eX290W4LoqsJUeUNYOR5JAuk7iTJtZH38EC46oFitBsnLzW0/5YSNL/v300p8w==";
          };
          gpg = {
            format = "ssh";
            ssh = { program = "op-ssh-sign"; };
          };
          core = { sshCommand = "ssh -i ~/.ssh/id_rsa_pinnsg.pub"; };
        };
        condition = "hasconfig:remote.*.url:git@gitlab.com:pinnsg/*";
      }
    ];
  };

  # Required for fish commands
  home.packages = with pkgs; [ fish fzf bat ];
}
