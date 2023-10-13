{ config
, pkgs
, lib
, ...
}: {
  programs.git = {
    inherit (sops.secrets.git.drmikecrowe) userName userEmail;
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
      core = { editor = "nvim"; };
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
    };

    includes = [
      {
        contents = {
          user = {
            name = "Mike Crowe";
            email = "drmikecrowe@gmail.com";
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
