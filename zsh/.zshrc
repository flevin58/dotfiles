# Add mystuff path
export MYSTUFF=$HOME/mystuff
export FINROOT=$HOME/mystuff
export EDITOR=nvim
export PATH=$MYSTUFF/bin:$MYSTUFF/scripts:$PATH
export LIBRARY_PATH="$(brew --prefix)/lib"

# Do the magic!
for zshfile in $MYSTUFF/zsh/*.zsh; do source $zshfile; done

# Add zsh plugins
plugins=(
	zsh-sutosuggestions
	zsh-syntax-highlighting
)

# Add starship command prompt
eval "$(starship init zsh)"

# Add zoxide functionality
eval "$(zoxide init zsh)"
alias cd="z"

# Kool computer info on screen
neofetch
