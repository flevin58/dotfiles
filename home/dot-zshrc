#############################################
# .zshrc                                    #
# Gets sourced at every terminal session    #
# Uses global env vars defined in .zshenv   #
#############################################

# Load antidote and plugins in "$HOME/.zsh_plugins.txt"
if [ ! -d "$HOME/.antidote" ]; then
        git clone --depth=1 https://github.com/mattmc3/antidote.git "$HOME/.antidote"
fi
source "$HOME/.antidote"
antidote load

# Set key bindings to zsh
bindkey -v
bindkey '^[[A' history-substring-search-up # or '\eOA'
bindkey '^[[B' history-substring-search-down # or '\eOB'
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

#
# Use lf to change dirs using Ctrl-e
#
# lfcd () {
#     tmp="$(mktemp)"
#     lf -last-dir-path="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#       dir="$(cat "$tmp")"
#       rm -f "$tmp"
#       [ -d "$dir" ] && [ $dir != "$(pwd)"] && cd "$dir"
#     fi
# }
# bindkey -s '^e' 'lfcd\n'

# Set history related stuff
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=${HOME}/.cache/zsh/history
test -d "$HOME/.cache/zsh" || mkdir -p "$HOME/.cache/zsh"
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Do the magic and source any .zsh file in local/zsh !!!
for zshfile in $HOME/.dotfiles/local/zsh/*.zsh; do
  source $zshfile;
done

# Add FuzzyFind integration
# eval "$(fzf --zsh)"

# Add oh-my-posh command prompt
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.dotfiles/local/omp/config.toml)"
fi

# Add zoxide functionality
# eval "$(zoxide init zsh)"
# alias cd="z"

# Kool computer info on screen
fastfetch

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
