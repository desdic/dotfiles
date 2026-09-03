# there should be no !# since we source this script to add it to our history
DIR=$(fd . --type directory --type symlink ~/ ~/.config ~/git ~/src/private --maxdepth 1|fzf +m --select-1 --prompt="directory > " --query="$1")
if [ -n "$DIR" ]; then

	if [ -n "$DIR" ]; then
		cd $DIR
	fi

	if [ -n "$TMUX" ]; then
		SHORT=$(echo $PWD|rev|cut -d '/' -f-2|rev|tr . _)
		tmux rename-window -- "${SHORT}"
	elif [ -n "$HERDR_ENV" ]; then
		SHORT=$(echo $PWD|rev|cut -d '/' -f-2|rev)
		herdr pane rename "${HERDR_PANE_ID}" "${SHORT}" > /dev/null
		PANE_COUNT=$(herdr tab get "$HERDR_TAB_ID"|jq .result.tab.pane_count)
		if [ "$PANE_COUNT" -eq 1 ]; then
			herdr tab rename "${HERDR_TAB_ID}" "${SHORT}" > /dev/null
		fi
	fi

fi
