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

# {{{ P10K instant prompt
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }}}

source "$_DOTFILESDIR/zsh/p10k.zsh"

# {{{ python venv
PYTHON_TOOLS_HOME=${XDG_DATA_DIR:-$HOME/.local/share}/venv/tools
[[ ! -d $PYTHON_TOOLS_HOME ]] && python3 -m venv $PYTHON_TOOLS_HOME
export PATH=$PATH:$PYTHON_TOOLS_HOME/bin
# }}}

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
zplug "junegunn/fzf", as:command, hook-build:"./install --bin", use:"bin/*"
zplug "junegunn/fzf", use:"shell/*.zsh"

zplug "pyenv/pyenv", as:command, hook-build:"src/configure && make -C src", use:"bin/*"
zplug "mhinz/neovim-remote", as:command, hook-build:"$PYTHON_TOOLS_HOME/bin/python3 -m pip install -e ."

zplug "romkatv/powerlevel10k", as:theme, depth:1

[[ -f "$_DOTFILESDIR/corp/zsh/plugins.zsh" ]] && source "$_DOTFILESDIR/corp/zsh/plugins.zsh"
# }}}

# {{{ zplug instal
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

# vim: set fdm=marker fmr={{{,}}} ts=4 sw=4 et:
