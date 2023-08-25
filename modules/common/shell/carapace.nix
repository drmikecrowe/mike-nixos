{ config, pkgs, lib, ... }: {

  options.carapace.enable = lib.mkEnableOption "carapace Shell History.";

  config.home-manager.users.${config.user} = lib.mkIf config.carapace.enable {

    home.packages = with pkgs; [ carapace ];
    programs.bash.bashrcExtra = ''
      source <(carapace _carapace)
    '';
    programs.nushell.extraConfig = lib.mkIf config.nushell.enable ''
      let carapace_completer = {|spans| 
        carapace $spans.0 nushell $spans | from json
      }

      mut current = (($env | default {} config).config | default {} completions)
      $current.completions = ($current.completions | default {} external)
      $current.completions.external = ($current.completions.external 
          | default true enable
          | default $carapace_completer completer)

      $env.config = $current
    '';
    programs.fish.shellInit = ''
      carapace _carapace | source
    '';
    home.file.".config/fish/setup-carapace.fish".text = ''
      mkdir -p ~/.config/fish/completions
      carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish # disable auto-loaded completions (#185)
    '';
  };

}
