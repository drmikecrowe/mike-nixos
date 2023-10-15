{ config
, pkgs
, lib
, user
, ...
}: {
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings.git_protocol = "https";
  };

  programs.fish = {
    shellAbbrs = {
      ghr = "gh repo view -w";
      gha = "gh run list | head -1 | awk '{ print $(NF-2) }' | xargs gh run view";
      grw = "gh run watch";
      grf = "gh run view --log-failed";
      grl = "gh run view --log";
      ghpr = "gh pr create && sleep 3 && gh run watch";

      # https://github.com/cli/cli/discussions/4067
      prs = "gh search prs --state=open --review-requested=@me";
    };
    functions = {
      repos = {
        description = "Clone GitHub repositories";
        argumentNames = "organization";
        body = ''
          set directory (gh-repos $organization)
          and cd $directory
        '';
      };
    };
  };
}
