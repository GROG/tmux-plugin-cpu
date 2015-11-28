# tmux-plugin-cpu

[![Build Status](https://travis-ci.org/GROG/tmux-plugin-cpu.svg?branch=master)](https://travis-ci.org/GROG/tmux-plugin-cpu)

This plugin let's you add the CPU usage to tmux status fields.


### Dependencies

None.


### Usage

Add one of the available values to your existing `status-left` or
`status-right` tmux option.

| Value | Description |
|-------|-------------|
| `#{cpu_percentage}` | CPU usage in percent |

The plugin also has some options to change the indicator.

| Value | Description | Default |
|-------|-------------|---------|
| `@cpu_pre_color` | Color code prepended to value | / |
| `@cpu_post_color` | Color code appended to value | `#[default]` |
| `@cpu_high_color` | Color code prepended for high CPU load | `#[fg=colour1]` |
| `@cpu_high_percentage` | Value for high CPU load |  75 |
| `@cpu_mid_color` | Color code prepended for middle CPU load | `#[fg=colour3]` |
| `@cpu_mid_percentage` | Value for middle CPU load |  35 |
| `@cpu_low_color` | Color code prepended for low CPU load | `#[fg=colour2]` |
| `@cpu_error_color` | Color code prepended for error codes | `#[fg=colour0]#[bg=colour1]` |
| `@cpu_custom_percentage` | Custom script to get CPU load | / |

Example:

    set -g status-right 'CPU:#{cpu_percentage}% | %a %h-%d %H:%M '

    set -g @plugin 'GROG/tmux-plugin-cpu'
    set -g @cpu_high_percentage "80"
    set -g @cpu_low_percentage "40"
    set -g @cpu_custom_percentage "$HOME/.scripts/cpu_percentage.sh"


### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'GROG/tmux-plugin-cpu'

Hit `prefix + I` to fetch the plugin and source it.


### Manual Installation

Clone the repo:

    $ git clone https://github.com/GROG/tmux-plugin-cpu ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/cpu.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf


### Special credit

This plugin is roughly based on the various plugins in
[https://github.com/tmux-plugins](https://github.com/tmux-plugins).


### License

[MIT](LICENSE)


### Contibuting

All assistance, changes or ideas
[welcome](https://github.com/GROG/tmux-plugin-cpu/issues)!


### Author

By [G. Roggemans](https://github.com/groggemans)
