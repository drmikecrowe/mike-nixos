{ stdenv
, config
, fetchFromGitHub
, writeShellScriptBin
, git
, neovim
, fd
, ripgrep
, dataHome
, configHome
, cacheHome
}:

let
  lvimSrc = stdenv.mkDerivation rec {
    pname = "lvim";
    version = "1.3.0";

    src = fetchFromGitHub {
      owner = "LunarVim";
      repo = "LunarVim";
      rev = version;
      sha256 = "z1Cw3wGpFDmlrAIy7rrjlMtzcW7a6HWSjI+asEDcGPA=";
    };

    dontConfigure = true;
    dontBuild = true;
    dontFixup = true;

    installPhase = ''
      mkdir -p $out/lvim
      cp -r . $out/lvim
    '';
  };
in

writeShellScriptBin "lvim" ''
  export LUNARVIM_CONFIG_DIR=${configHome}/lvim
  export LUNARVIM_CACHE_DIR=${cacheHome}/lvim
  export LUNARVIM_RUNTIME_DIR=${dataHome}/lunarvim
  export LUNARVIM_BASE_DIR=${lvimSrc}/lvim
  export PATH=${neovim}/bin:${ripgrep}/bin:${fd}/bin:${git}/bin:/usr/bin:$PATH
  exec -a lvim nvim -u $LUNARVIM_BASE_DIR/init.lua $@
''

