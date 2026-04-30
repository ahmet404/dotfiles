# Setup fzf
# ---------
if [[ ! "$PATH" == */home/badcoder/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/badcoder/.fzf/bin"
fi

source <(fzf --zsh)
