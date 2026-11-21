#!/usr/bin/env bash

set -u

script_dir="${HOME}/.scripts"

if [[ ! -d "$script_dir" ]]; then
    rofi -e "No scripts directory found: ${script_dir}"
    exit 1
fi

mapfile -t scripts < <(
    find "$script_dir" -maxdepth 1 -type f -name '*.sh' -printf '%f\n' \
        | sed 's/\.sh$//' \
        | sort
)

if (( ${#scripts[@]} == 0 )); then
    rofi -e "No .sh scripts found in ${script_dir}"
    exit 1
fi

selected_script=$(printf '%s\n' "${scripts[@]}" | rofi -dmenu -i -p "Select script")

if [[ -z "${selected_script}" ]]; then
    exit 0
fi

script_path="${script_dir}/${selected_script}.sh"

if [[ ! -f "$script_path" ]]; then
    rofi -e "Script not found: ${script_path}"
    exit 1
fi

bash "$script_path"
