# {{{ Default .zshrc contents
# Set up the prompt

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
which dircolors > /dev/null 2> /dev/null && eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
# }}}

# {{{ Utilities
# Find exact dotfiles directory
function _find_dotfiles_dir() {
    unset -f _find_dotfiles_dir
    local SOURCE
    local _DOTFILESDIR
    SOURCE="${(%):-%x}"
    while [[ -h "$SOURCE" ]]; do
        _DOTFILESDIR="$(cd -P "$(dirname "$SOURCE")" 2> /dev/null; pwd)"
        SOURCE="$(readlink "$SOURCE")"
        [[ "$SOURCE" != /* ]] && SOURCE="$_DOTFILESDIR/$SOURCE"
    done
    _DOTFILESDIR="$(cd -P "$(dirname "$SOURCE")/.." 2> /dev/null; pwd)"
    echo "$_DOTFILESDIR"
}
_DOTFILESDIR=$(_find_dotfiles_dir)
# }}}

# {{{ python venv
PYTHON_TOOLS_HOME=${XDG_DATA_DIR:-$HOME/.local/share}/venv/tools
[[ ! -d $PYTHON_TOOLS_HOME ]] && python3 -m venv $PYTHON_TOOLS_HOME
export PATH=$PATH:$PYTHON_TOOLS_HOME/bin
# }}}

source "$_DOTFILESDIR/zsh/p10k.zsh"

# {{{ load zplug
export ZPLUG_HOME=$HOME/.zplug
if [ ! -e "$ZPLUG_HOME" ]; then
    git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
fi

source $ZPLUG_HOME/init.zsh
# }}}

# {{{ zplug plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "mafredri/zsh-async", use:"async.zsh"

zplug "zdharma-continuum/fast-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "junegunn/fzf", use:"shell/*.zsh", hook-build:"./install --bin"
zplug "junegunn/fzf", as:command, use:"bin/*"

zplug "pyenv/pyenv", as:command, hook-build:"src/configure && make -C src", use:"bin/*"
zplug "mhinz/neovim-remote", as:command, hook-build:"$PYTHON_TOOLS_HOME/bin/python3 -m pip install -e ."
zplug "aitjcize/cppman", as:command, hook-build:"$PYTHON_TOOLS_HOME/bin/python3 -m pip install -e ."

zplug "romkatv/powerlevel10k", as:theme, depth:1

[[ -f "$_DOTFILESDIR/corp/zsh/plugins.zsh" ]] && source "$_DOTFILESDIR/corp/zsh/plugins.zsh"
# }}}

# {{{ zplug install
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
# }}}

# {{{ P10K instant prompt
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }}}

# vim: set fdm=marker fmr={{{,}}} ts=4 sw=4 et:
