container_fzf() {
	local cmds=()

	# handle kitchen builds
	KITCHENDIR=
	if [ -e kitchen-build/.kitchen ]; then
		KITCHENDIR=kitchen-build/.kitchen
	elif [ -e .kitchen ]; then
		KITCHENDIR=.kitchen
	fi

	# handle kitchen in cookbooks
	if [[ -f .kitchen.yml ]]; then
		cmds+=("kitchen destroy")
		while read -r entry; do
			cmds+=("kitchen destroy $entry")
			cmds+=("kitchen converge $entry")
			cmds+=("kitchen verify $entry")
			cmds+=("kitchen test $entry")
			cmds+=("kitchen login $entry")
		done < <(kitchen list --bare)
	fi

	if [ -n "${KITCHENDIR}" ]; then
		while read -r entry; do
			KHOST=$(awk '/^hostname:/{print $2}' "$entry")
			KPORT=$(awk '/^port:/{print $2}' "$entry")
			KUSERNAME=$(awk '/^username:/{print $2}' "$entry")
			KKEY=$(awk -F '"' '/^ssh_key:/{print $2}' "$entry")
			cmds+=("ssh -o StrictHostKeyChecking=no \"$KUSERNAME\"@\"$KHOST\" -i \"$KKEY\" -p \"$KPORT\"")
		done < <(find "${KITCHENDIR}" -iname '*.yml')
	fi

	# handle docker
	while read -r entry; do
		cmds+=("docker exec -it $entry /bin/bash")
		cmds+=("docker kill $entry")
	done < <(docker ps --format '{{.Names}}')


	local selected
	selected=$(printf "%s\n" "${cmds[@]}" | fzf -m --prompt="cmd > " --color "prompt:#89b4fa" --query="$1") || return

	# Execute selected commands in main shell
	for cmd in ${(f)selected}; do
		echo "🚀 Executing: $cmd"
		print -s "$cmd"
		fc -W
		eval "$cmd"
	done
}
