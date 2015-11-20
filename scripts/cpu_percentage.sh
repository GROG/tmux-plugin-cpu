#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/shared.sh

pre_color=""
post_color=""
high_color=""
high_percentage=""
mid_color=""
mid_percentage=""
low_color=""
error_color=""
custom_percentage=""

d_pre_color=""
d_post_color="#[default]"
d_high_color="#[fg=colour1]"
d_high_percentage="75"
d_mid_color="#[fg=colour3]"
d_mid_percentage="35"
d_low_color="#[fg=colour2]"
d_error_color="#[fg=colour0]#[bg=colour1]"
d_custom_percentage=""

init_vars() {
    init_var "cpu" "pre_color"
    init_var "cpu" "post_color"
    init_var "cpu" "high_color"
    init_var "cpu" "high_percentage"
    init_var "cpu" "mid_color"
    init_var "cpu" "mid_percentage"
    init_var "cpu" "low_color"
    init_var "cpu" "error_color"
    init_var "cpu" "custom_percentage"
}

cpu_value() {
    if is_cygwin; then
        WMIC cpu get LoadPercentage |\
        grep -Eo '^[0-9]+' |\
        awk '{printf("%02d\n", $1)}'
    elif [ -e "/proc/stat" ]; then
        grep 'cpu ' /proc/stat |\
        awk '{printf("%02d", ($2+$4)*100/($2+$4+$5))}'
    elif is_osx; then
        iostat -w 1 -c 2 -n 1 |\
        tail -1 |\
        awk '{printf("%02d", 100-$6)}'
    elif command_exists "top"; then
        top -d 0.5 -b -n 2 |\
        grep 'Cpu(s)' |\
        tail -1 |\
        awk '{printf("%02d\n", 100-$8)}'
    elif [ -x $custom_percentage ]; then
        eval $custom_percentage
    fi
}

cpu_percentage() {
    local cpu_p=$(cpu_value)

    if [ -z "$cpu_p" ]; then
        print_color "error" "EE"
    elif [ "$cpu_p" -gt "$high_percentage" ]; then
        print_color "high" "$cpu_p"
    elif [ "$cpu_p" -gt "$mid_percentage" ]; then
        print_color "mid" "$cpu_p"
    else
        print_color "low" "$cpu_p"
    fi
}

main() {
    init_vars
	cpu_percentage
}
main
