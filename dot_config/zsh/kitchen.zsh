kitchen_fzf() {
  (
    echo "kitchen destroy"
    kitchen list --bare | while read -r entry; do
      echo "kitchen destroy $entry"
      echo "kitchen converge $entry"
      echo "kitchen verify $entry"
      echo "kitchen test $entry"
      echo "kitchen login $entry"
    done
  ) | fzf -m --prompt="cmd > " --color "prompt:#89b4fa" +m --query="$1" | while read -r cmd_to_run; do
    echo "🚀 Executing: $cmd_to_run"

    # Add to interactive Zsh history
    print -s "$cmd_to_run"
    fc -W  # write to history file

    # Execute the command
    eval "$cmd_to_run"
  done
}
