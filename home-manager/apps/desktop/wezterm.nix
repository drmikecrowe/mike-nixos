{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wezterm
  ];

  xdg.configFile."wezterm/wezterm.lua".text = ''
    return {
      font_size = 14,
      window_background_opacity = 1,
      hide_tab_bar_if_only_one_tab = true,
      default_cursor_style = "BlinkingUnderline",
      cursor_blink_rate = 600,
    }
  '';
}

# https://github.com/jssee/base16-framer-scheme
# base00: "#181818" # black
# base01: "#151515" # ----
# base02: "#464646" # ---
# base03: "#747474" # --
# base04: "#B9B9B9" # ++
# base05: "#D0D0D0" # +++
# base06: "#E8E8E8" # ++++
# base07: "#EEEEEE" # white
# base08: "#FD886B" # orange
# base09: "#FC4769" # red
# base0A: "#FECB6E" # yellow
# base0B: "#32CCDC" # green
# base0C: "#ACDDFD" # cyan
# base0D: "#20BCFC" # blue
# base0E: "#BA8CFC" # purple
# base0F: "#B15F4A" # brown
