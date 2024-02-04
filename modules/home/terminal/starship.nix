{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true; # Don"t print new line at the start of the prompt
      format = lib.concatStrings [
        "$shell"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$jobs"
        "$cmd_duration"
        "$nix_shell"
        "$character"
      ];
      # right_format = "$nix_shell";
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[!](bold green)";
      };
      cmd_duration = {
        min_time = 5000;
        show_notifications =
          if pkgs.stdenv.isLinux
          then false
          else true;
        min_time_to_notify = 30000;
        format = "[$duration]($style) ";
      };
      directory = {
        truncate_to_repo = true;
        truncation_length = 100;
      };
      git_branch = {format = "[$symbol$branch]($style)";};
      git_commit = {
        format = "( @ [$hash]($style) )";
        only_detached = false;
      };
      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        conflicted = "=";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "⋄";
        stashed = "⩮";
        modified = "∽";
        staged = "+";
        renamed = "»";
        deleted = "✘";
        style = "red";
      };
      hostname = {
        ssh_only = true;
        format = "on [$hostname](bold red) ";
      };
      nix_shell = {
        impure_msg = "[impure shell](bold red)";
        pure_msg = "[pure shell](bold green)";
        unknown_msg = "[unknown shell](bold yellow)";
        format = "[$symbol $name]($style)";
        symbol = "❄️";
      };
      package = {
        format = "via [🎁 $version](208 bold) ";
      };
      python = {format = "[\${version}\\(\${virtualenv}\\)]($style)";};
      shell = {
        fish_indicator = "󰈺 ";
        powershell_indicator = "_";
        unknown_indicator = "mystery shell";
        style = "cyan bold";
      };
    };
  };
}
