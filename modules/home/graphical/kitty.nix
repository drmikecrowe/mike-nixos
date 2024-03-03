{
  custom,
  lib,
  pkgs,
  ...
}: {
  programs.kitty = lib.mkIf custom.gui {
    enable = true;
    environment = {};
    extraConfig = "";
    font.size = 12;
    font.name = "FiraCode";
    keybindings = {
      "kitty_mod+b" = "scroll_page_up";
      "kitty_mod+f" = "scroll_page_down";
      "kitty_mod+enter" = "new_window_with_cwd";
      "kitty_mod+h" = "previous_window";
      "kitty_mod+l" = "next_window";
      "kitty_mod+j" = "previous_tab";
      "kitty_mod+k" = "next_tab";
      "kitty_mod+t" = "new_tab_with_cwd";
      "kitty_mod+0" = "goto_layout tall";
      "kitty_mod+1" = "goto_layout horizontal";
      "kitty_mod+equal" = "change_font_size current +2.0";
      "kitty_mod+minus" = "change_font_size current -2.0";
      "kitty_mod+backspace" = "change_font_size current 0";
      "kitty_mod+c" = "copy_to_clipboard";
      "kitty_mod+v" = "paste_from_clipboard";
      "ctrl+alt+shift+n" = "launch kitty nu -li";
      "ctrl+alt+shift+b" = "launch kitty bash -li";
      "ctrl+k" = "clear_terminal reset active";
    };

    settings = {
      kitty_mod = "ctrl+shift";

      # Theme
      theme = "Alabaster Dark";

      # Scrollback
      scrolling_lines = 10000;
      scrollback_pager_history_size = 10; # MB
      scrollback_pager = "${pkgs.neovim}/bin/nvim -c 'normal G'";

      # Window
      window_padding_width = 6;

      tab_bar_edge = "top";
      tab_bar_style = "slant";

      # Audio
      enable_audio_bell = false;
    };
  };
}
