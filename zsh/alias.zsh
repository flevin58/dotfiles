# Add basic aliases
alias ls="eza --icons=always"
alias ll="ls -l"
alias lt="ls -lt"
alias la="ls -al"
alias godev="cd ~/Sviluppo"
alias godot="cd $DOTFILES"
# Add go-related aliases
alias gor="go run ."
alias got="go test -v ./..."
alias goi="go install"
alias gou="go clean -i"
alias gob="go build"
alias gogo="cd ~/Sviluppo/Go"
# Add rust-related aliases
alias gorust="cd ~/Sviluppo/Rust"
alias cr="cargo run -q --"
alias ct="cargo test"
# Add zig-related aliases
alias gozig="cd ~/Sviluppo/Zig"
alias zbr="zig build run"
alias zbt="zig build test --summary all"
# Add more advanced aliases
alias edit="$EDITOR"
alias remove="rm -rf"
alias reload="source ~/.zshrc"
alias vim=nvim
alias vienv="vi ~/.env"
alias viconf="vi ~/.zshrc.flevin58"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron"
alias tree="tree --gitignore"
alias tree2="tree --gitignore -L 2"
alias tree3="tree --gitignore -L 3"
alias brewup="brew update && brew upgrade"
