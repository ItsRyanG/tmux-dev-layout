# tmux-dev-layout

Fish shell functions for a tmux IDE-style layout: editor on the left, an AI
agent (opencode/claude/codex) on the right, and a terminal strip along the
bottom.

Ported from [Omarchy](https://omarchy.org)'s built-in bash functions
(`/usr/share/omarchy/default/bash/fns/tmux`), which only work in bash. This
version is plain fish, no Omarchy dependency, so it works anywhere fish +
tmux are installed (tested on Linux/Omarchy and macOS/Ghostty).

It also fixes a bug in the upstream `tdl`: the final `tmux select-pane`
referenced an unset `$opencode_pane` (a copy/paste leftover from the
`tds` function), so focus never landed on the editor. Fixed to use
`$editor_pane`.

## Functions

- `tdl <agent> [<agent2>]` — three-way split: editor left, `agent` top-right,
  terminal bottom. Give a second agent to stack two AI panes on the right
  (e.g. `tdl c cx`).
- `tds` — 2x2 square: editor, `hunk diff --watch`, terminal, and `opencode`.
  Requires [hunk](https://github.com/andrewculver/hunk) for the diff pane.
- `tdlm <agent> [<agent2>]` — runs `tdl` once per subdirectory of the
  current directory, each in its own tmux window.
- `tsl <pane_count> <command>` — tiled layout, same command in every pane.

## AI agent aliases

- `c` → `opencode --auto`
- `cx` → `claude --permission-mode bypassPermissions` (clears the screen first)
- `cy` → `codex -s danger-full-access -a never`
- `ic` → `tdl c`
- `ix` → `tdl cx`
- `icx` → `tdl c cx`

These match Omarchy's default aliases so muscle memory carries over.

## Install

```fish
mkdir -p ~/.config/fish/functions
cp fish/functions/*.fish ~/.config/fish/functions/
```

Fish autoloads anything in `functions/` — no need to source it from
`config.fish`.

## Dependencies

- `tmux` (must be run from inside a session — these functions split the
  current window)
- `$EDITOR` set to whatever editor you want in the left pane (defaults to
  whatever's exported in your shell config; these functions don't set it
  themselves)
- the AI CLIs you use: `opencode`, `claude`, and/or `codex` on `$PATH`

## macOS / Ghostty setup notes

- `brew install tmux fish`
- Make fish your shell in Ghostty: Ghostty uses your login shell by default,
  so `chsh -s $(which fish)` (or set `command` in Ghostty's config to launch
  fish explicitly).
- Install the AI CLIs the same way you did on Linux (npm/brew/curl installer
  per tool) and confirm `opencode`/`claude`/`codex` resolve on `$PATH`.
- No other Omarchy-specific pieces are required — these functions only shell
  out to `tmux`, `basename`, `tr`, and whatever agent command you pass in.

## Usage

```fish
cd ~/code/some-project
tdl c        # editor + opencode + terminal
ic           # same as above
ix           # editor + claude + terminal
tdl c cx     # editor + opencode + claude stacked + terminal
tsl 3 'echo hi'   # 3 tiled panes all running the same command
```
