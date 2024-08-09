{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib) mkEnableOption mkOption types;

  mkOnOff = description: default:
    mkOption {
      inherit default description;
      type = types.bool;
      example = !default;
    };

  mkLsp = lang: mkOnOff ("Install " + lang + " binaries") true;
  mkDisable = lang: mkOnOff ("Install " + lang + " binaries") false;
  mkLang = lang: {enable = mkLsp lang;};
  mkLangDisable = lang: {enable = mkDisable lang;};
  cfg = config.host.application.lsp;
in {
  options = {
    host.application.lsp = {
      enable = mkEnableOption "Enable neovim LSP installation";

      web = {
        enable = mkOnOff "Enable web LSPs" true;

        typescript = mkLsp "typescript";
        prettier = mkLsp "prettier";
        eslint = mkLsp "eslint";
        vue = mkLsp "vue";
        svelte = mkLsp "svelte";
        # react = mkLsp "react";
        tailwind = mkLsp "tailwind";

        deno = mkLsp "deno";
      };

      lua = mkLang "lua";
      nix = mkLang "nix";
      python = mkLang "python";
      shell = mkLang "shell";
      go = mkLang "go";
      rust = mkLang "rust";
      terraform = mkLang "terraform";

      cpp = mkLangDisable "cpp";
      php = mkLangDisable "php";
      java = mkLangDisable "java";
      dotnet = mkLangDisable "dotnet";
      zig = mkLangDisable "zig";
      haskell = mkLangDisable "haskell";

      yaml = {
        enable = mkLsp "yaml";

        docker = mkLsp "docker";
        kubernetes = mkDisable "kubernetes";
        ansible = mkDisable "ansible";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = let
      inherit (lib) optional optionals;

      default = with pkgs; [
        tree-sitter
        # git
        curl
        gnutar
        gnumake
        trashy
        efm-langserver
        nodePackages_latest.vscode-json-languageserver
        buf-language-server
        wl-clipboard
        xclip
      ];

      web = with pkgs; ([
          vscode-langservers-extracted
          nodejs_20
        ]
        ++ (optionals cfg.web.typescript [typescript-language-server typescript nodePackages.eslint biome])
        ++ (optionals cfg.web.prettier [prettierd nodePackages.prettier])
        ++ (optionals cfg.web.eslint [eslint_d nodePackages.eslint])
        ++ (optional cfg.web.vue vscode-extensions.vue.volar)
        ++ (optional cfg.web.svelte nodePackages.svelte-language-server)
        ++ (optional cfg.web.tailwind tailwindcss-language-server)
        ++ (optional cfg.web.deno deno));

      lua = with pkgs; [
        lua5_1
        lua51Packages.luarocks
        lua-language-server
        stylua
        selene
      ];
      nix = with pkgs; [
        nixd
        nil
        alejandra
      ];
      rust = with pkgs; [
        cargo # switch to use fenix ?
        rustfmt
        graphviz # for rust-analyzer
      ];
      python = with pkgs; [
        black
        ruff
        ruff-lsp
        python3Packages.debugpy
        poetry
        pyright
      ];
      shell = with pkgs; [
        shellcheck
        shfmt
        bash-language-server
        # fish-lsp
      ];
      go = with pkgs; [
        pkgs.go
        gopls
      ];
      cpp = with pkgs; [
        clang-tools
        gcc
        lldb
      ];
      tf = with pkgs; [
        cuelsp
        terraform
        terraform-ls
        tflint
      ];

      yaml = with pkgs; ([yaml-language-server]
        ++ (optionals cfg.yaml.docker [
          dockerfile-language-server-nodejs
          docker-compose-language-service
          hadolint
        ]));

      installed =
        default
        ++ (optionals cfg.web.enable web)
        ++ (optionals cfg.lua.enable lua)
        ++ (optionals cfg.nix.enable nix)
        ++ (optionals cfg.rust.enable rust)
        ++ (optionals cfg.python.enable python)
        ++ (optionals cfg.shell.enable shell)
        ++ (optionals cfg.go.enable go)
        ++ (optionals cfg.terraform.enable tf)
        ++ (optionals cfg.cpp.enable cpp)
        ++ (optionals cfg.yaml.enable yaml);
    in
      installed;
  };
}
