# Find exact dotfiles directory
function _find_dotfiles_dir() {
    unset -f _find_dotfiles_dir
    local SOURCE
    local DOTFILESDIR
    SOURCE="${(%):-%x}"
    while [[ -h "$SOURCE" ]]; do
        DOTFILESDIR="$(cd -P "$(dirname "$SOURCE")" 2> /dev/null; pwd)"
        SOURCE="$(readlink "$SOURCE")"
        [[ "$SOURCE" != /* ]] && SOURCE="$DOTFILESDIR/$SOURCE"
    done
    DOTFILESDIR="$(cd -P "$(dirname "$SOURCE")/.." 2> /dev/null; pwd)"
    echo "$DOTFILESDIR"
}
_DOTFILESDIR=$(_find_dotfiles_dir)

export DOTFILESDIR=$_DOTFILESDIR

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'
export PATH=/usr/local/go/bin:$HOME/bin:$PATH:/snap/bin:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.local/bin:$HOME/go/bin:$_DOTFILESDIR/bin:$_DOTFILESDIR/corp/bin

if ls --color -d . >/dev/null 2>&1; then
    # GNU ls
    alias ls='ls --color=auto'
elif ls -G -d . >/dev/null 2>&1; then
    # BSD ls
    alias ls='ls -G'
else
    # Solaris ls
fi
alias node='node --experimental-repl-await'
test -e "$HOME/.cargo/env" && . "$HOME/.cargo/env"

if [[ ! "$XDG_CONFIG_DIRS" == "*$_DOTFILESDIR*" ]]; then
    if [ -z "$XDG_CONFIG_DIRS" ]; then
        export XDG_CONFIG_DIRS=$_DOTFILESDIR
    else
        export XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:$_DOTFILESDIR
    fi
fi

export HGRCPATH=$_DOTFILESDIR/hg/mercurial.ini

if [[ "$(basename "${WEZTERM_EXECUTABLE}")" = "wezterm-mux-server" ]]; then
  # We are running in wezterm mux mode
  export SSH_AUTH_SOCK="$HOME/.wezterm-auth-sock"
fi

[ -f $_DOTFILESDIR/corp/zsh/env.zsh ] && source $_DOTFILESDIR/corp/zsh/env.zsh

# vim: set fdm=marker fmr={{{,}}} sw=4 ts=4 et:
