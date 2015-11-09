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

d_pre_color=""
d_post_color="#[default]"
d_high_color="#[fg=colour1]"
d_high_percentage="75"
d_mid_color="#[fg=colour3]"
d_mid_percentage="35"
d_low_color="#[fg=colour2]"
d_error_color="#[fg=colour0]#[bg=colour1]"

init_vars() {
    init_var "pre_color"
    init_var "post_color"
    init_var "high_color"
    init_var "high_percentage"
    init_var "mid_color"
    init_var "mid_percentage"
    init_var "low_color"
    init_var "error_color"
}

cpu_percentage() {
    if command_exists "top" &&
        command_exists "grep" &&
        command_exists "tail" &&
        command_exists "awk"; then
        local cpu_p=$(top -d 0.5 -b -n 2 |\
                        grep 'Cpu(s)' |\
                        tail -1 |\
                        awk '{printf("%02d\n", 100-$8)}')

        if [ "$cpu_p" -gt "$high_percentage" ]; then
            print_color "high" "$cpu_p"
        elif [ "$cpu_p" -gt "$mid_percentage" ]; then
            print_color "mid" "$cpu_p"
        else
            print_color "low" "$cpu_p"
        fi

    else
        print_color "error" "EE"
    fi
}

main() {
    init_vars
	cpu_percentage
}
main
