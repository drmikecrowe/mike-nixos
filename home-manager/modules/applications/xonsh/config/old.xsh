import os
from datetime import datetime
from xonsh.platform import ON_LINUX, ON_DARWIN  # ON_DARWIN, ON_WINDOWS, ON_WSL, ON_CYGWIN, ON_MSYS, ON_POSIX, ON_FREEBSD, ON_DRAGONFLY, ON_NETBSD, ON_OPENBSD

# xpip install xonsh-docker-tabcomplete xontrib-ssh-agent xonsh-direnv xontrib-prompt-starship xontrib-readable-traceback

# pipx inject xonsh xontrib-argcomplete xontrib-zoxide xxh-xxh xonsh-autoxsh xontrib-chatgpt xonsh-direnv xontrib-prompt-starship xontrib-readable-traceback xontrib-termcolors xontrib-brace-expansion xontrib-gitinfo xontrib-sh
# xpip install xontrib-termcolors
# xpip install xonsh-apt-tabcomplete
# xpip install xontrib-xlsd
# xpip install xonsh-autoxsh
# xpip install xontrib-srename

_xontribs = [
    "docker_tabcomplete",
    "ssh_agent",
    "direnv",
    # "prompt_starship",
    "coreutils",
    "readable-traceback",
    "termcolors",
    "autoxsh",
    "xlsd",
    "srename",
    "pyenv",
    "nodenv",
    "goenv",
    "rbenv"
]
if _xontribs:
    xontrib load @(_xontribs)

$STARSHIP_SHELL = "xonsh"
$BINARY_SSH="/usr/bin/ssh"

# -------------------------------------------------------------------------------------------------------------------------------------------------------------
# aliases
# -------------------------------------------------------------------------------------------------------------------------------------------------------------

aliases["....."] = 'cd ../../../..'
aliases["...."] = 'cd ../../..'
aliases["..."] = 'cd ../..'
aliases[".."] = 'cd ..'
aliases["cnc"] = 'grep "^[^#;]"'
aliases["dud"] = 'du -h --max-depth=1 --one-file-system'
aliases["dudg"] = 'du -h --max-depth=1 --one-file-system 2>&1 | egrep "^[0-9.]*G"'
aliases["gh"] = 'history | grep --colour=auto'
aliases["grep"] = "grep --color --exclude-dir='.svn' --exclude-dir='.git'"
aliases["tail"] = 'tail -n 30'
aliases["ta"] = 'tmux attach -t'
aliases["tnew"] = 'tmux new -s'
aliases["tls"] = 'tmux ls'
aliases["tkill"] = 'tmux kill-session -t'
aliases["hc"] = "history show all | grep -v EOF"
aliases["dotbare"] = "~/.dotbare/dotbare"

# Using rsync instead of cp to get the progress and speed of copying.
# aliases['cp'] = ['rsync', '--progress', '--recursive', '--archive']

# Make directory and cd into it.
# Example: md /tmp/my/awesome/dir/will/be/here
aliases['md'] = lambda args: execx(f'mkdir -p {repr(args[0])} && cd {repr(args[0])}')

# Run http server in the current directory.
aliases['http-here'] = 'python3 -m http.server'

def setLsAliases(colorflag):
    # aliases["ls"] = f"ls {colorflag}"
    colorflag = ""
    aliases["l"] = f"ls -l {colorflag}"
    aliases["ll"] = f"ls -l {colorflag}"
    aliases["la"] = f"ls -la {colorflag}"
    aliases["ls1b"] = "/usr/bin/ls -1b "

if ON_DARWIN:
    $LSCOLORS = 'BxBxhxDxfxhxhxhxhxcxcx'
    setLsAliases("-G")

if ON_LINUX:
    $LS_COLORS = 'no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
    setLsAliases("--color")

    aliases["acs"] = 'aptitude search'
    aliases["agi"] = 'sudo aptitude install'
    aliases["agu"] = 'sudo aptitude update'
    aliases["psa"] = 'ps faux'
    aliases["psag"] = 'ps faux | grep'

try:
	$EDITOR = ('code -n -w' if $DISPLAY else 'vim')
except (Exception):
	$EDITOR = 'vim'

# -------------------------------------------------------------------------------------------------------------------------------------------------------------
# Cross platform
# -------------------------------------------------------------------------------------------------------------------------------------------------------------

$XONSH_SHOW_TRACEBACK = False

# Avoid typing cd just directory path.
# Docs: https://xonsh.github.io/envvars.html#auto-cd
$AUTO_CD = True

# Don't clear the screen after quitting a manual page.
$MANPAGER = "less -X"
$LESS = "--ignore-case --quit-if-one-screen --quit-on-intr FRXQ"

$PUSHD_SILENT = True

# -------------------------------------------------------------------------------------------------------------------------------------------------------------
# History
# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# $XONSH_STORE_STDOUT = True
$XONSH_HISTORY_BACKEND = 'sqlite'
$XONSH_HISTORY_SIZE = (2**14, 'commands')
$XONSH_PROC_FREQUENCY = 0.002 # eat less CPU if threading prediction goes awry
$XONSH_HISTORY_MATCH_ANYWHERE = True
$HISTCONTROL='ignoredups'

# from xonsh.history.json import JsonHistory
# class SaveAllHistory(JsonHistory):
from xonsh.history.sqlite import SqliteHistory
class SaveAllHistory(SqliteHistory):
  def append(self, cmd):
    try:
      cwd = "{}/.logs{}".format(__xonsh__.env["HOME"], __xonsh__.env["PWD"])
      if not os.path.exists(cwd): os.makedirs(cwd)
      file = "{}/xonsh-history-{}.log".format(cwd, datetime.now().strftime("%Y-%m-%d"))
      open(file, "a").write("{} {}".format(datetime.now().strftime("%Y-%m-%d.%H.%M.%S"), cmd["inp"]))
      super().append(cmd)
    except Exception:
      print("History not being saved")
$XONSH_HISTORY_BACKEND = SaveAllHistory

# -------------------------------------------------------------------------------------------------------------------------------------------------------------
# Platform specific
# -------------------------------------------------------------------------------------------------------------------------------------------------------------

if ON_DARWIN:
    pass

if ON_LINUX:
    aliases["acs"] = 'aptitude search'
    aliases["agi"] = 'sudo aptitude install'
    aliases["agu"] = 'sudo aptitude update'
    aliases["psa"] = 'ps faux'
    aliases["psag"] = 'ps faux | grep'

    if os.path.exists("/usr/bin/ksshaskpass"):
        $SSH_ASKPASS = '/usr/bin/ksshaskpass'

    xontrib load apt_tabcomplete