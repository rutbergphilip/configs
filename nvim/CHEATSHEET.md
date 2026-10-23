# Neovim Cheat Sheet

Leader is `Space`. `<leader>uk` means: press Space, release, press `u`, press `k`. Close this window with `q`.
`<leader>uK` toggles the small key HUD in the corner. `<leader>sk` searches every keymap by name.

## Start here: how Neovim actually works

**Modes.** You are always in a mode. The bottom-left of the status line shows it.

- *Normal* (default): keys are commands, not text. `j` moves down, `dd` deletes a line. Get here with `Esc`.
- *Insert*: typing inserts text. Enter with `i`, `a`, `o`. Leave with `Esc`.
- *Visual*: select text. Enter with `v` (chars), `V` (lines), `Ctrl-v` (block). Then run an operator like `d`, `y`, `>`.
- *Command*: `:` opens a prompt at the bottom. `:w` save, `:q` quit, `:qa!` quit everything without saving.

**Lost? Press `Esc` twice.** That cancels any half-typed command and returns to Normal mode.

**Focus.** Only one window has the cursor. The key HUD in the corner is a *billboard*: it never takes focus and you
never type into it. `<leader>uJ` flips its page from wherever you are. The big cheat sheet (`<leader>uk`) *does* take
focus, so you can scroll it with `j`/`k` and search it with `/`. Press `q` to close it and get your focus back.

**Floating windows** (pickers, lazygit, cheat sheet, Copilot Chat) close with `q` or `Esc`. If one gets stuck, `:q`.

**Windows vs buffers vs tabs.** A *buffer* is an open file. A *window* is a view onto a buffer. Splits make more windows.
`Shift-h` / `Shift-l` cycle buffers in the current window. `Ctrl-h/j/k/l` move between windows. You rarely need tabs.

**The popup after Space** is which-key. It lists what each next key does. Keep pressing letters to go deeper, `Backspace`
to go up, `Esc` to cancel. If you ever wonder "what does Space g do?", press Space, g, and read.

**Repeat and undo.** `.` repeats your last change. `u` undoes, `Ctrl-r` redoes. Make mistakes freely.

**Help is built in.** `:help dd`, `:help text-objects`, `:help :g`. `K` on a word in a Lua config file opens its docs.
`:Tutor` is a 30-minute interactive lesson. Do it once.

**Your first five minutes, in order**

1. `<leader><space>` → type part of a filename → `Enter`. You just fuzzy-found a file.
2. `Esc`, then `/` → type a word → `Enter`. `n` for the next match.
3. `ciw` on a word, type a replacement, `Esc`. Then `.` on another word repeats it.
4. `<leader>gg` opens lazygit. `q` closes it.
5. `<leader>e` opens the file tree. `<leader>e` again closes it.

## Week 1 — survive and move

| Keys | What |
|---|---|
| `h j k l` | left / down / up / right (hardtime will nag if you spam these) |
| `w` `b` `e` | next word start / previous word start / word end (`W B E` = whitespace words) |
| `0` `^` `$` | line start / first non-blank / line end |
| `gg` `G` `42G` | top / bottom / line 42 (`:42` also works) |
| `{` `}` | previous / next blank line (paragraph) |
| `%` | jump to matching bracket |
| `Ctrl-d` `Ctrl-u` | half page down / up (stays centered) |
| `Ctrl-o` `Ctrl-i` | jump back / forward in jumplist (works across files) |
| `zz` `zt` `zb` | center / top / bottom the current line |
| `f{c}` `t{c}` `;` `,` | jump to / before char on line; repeat; repeat backwards |
| `s{ab}` | **Flash**: type 2 chars, then the label to jump anywhere on screen |
| `S` | Flash treesitter: select the surrounding node |
| `*` `#` | search word under cursor forward / backward |
| `n` `N` | next / previous match, `<Esc>` clears highlight |
| `i a I A o O` | insert before / after cursor, at line start / end, line below / above |
| `u` `Ctrl-r` | undo / redo (`<leader>U` shows the whole undo tree) |
| `.` | **repeat last change** — the single most powerful key |

## Week 2 — operators × motions × text objects

Every edit is `operator` + `motion/text object`. Learn the grammar, not the keys.

| Operators | |
|---|---|
| `d` `c` `y` | delete / change / yank |
| `>` `<` `=` | indent / dedent / auto-indent |
| `gu` `gU` `g~` | lowercase / uppercase / toggle case |
| `gc` | toggle comment (`gcc` for the line) |
| `gsa` `gsd` `gsr` | surround add / delete / replace (`gsaiw"` wraps word in quotes) |

| Text objects (`i` = inner, `a` = around) | |
|---|---|
| `iw` `aw` | word |
| `i"` `i'` `` i` `` | inside quotes |
| `i(` `i[` `i{` `i<` `it` | inside brackets / tag |
| `if` `af` | function (treesitter) |
| `ic` `ac` | class (treesitter) |
| `ia` `aa` | argument / parameter |
| `ii` `ai` | indentation level |
| `ip` `ap` | paragraph |

Examples: `ciw` change word, `da"` delete quoted string incl. quotes, `yif` yank function body, `vit` select tag contents, `cia` change argument, `>ap` indent paragraph.

Counts multiply: `3dd`, `2ciw`, `d3w`, `5j`.

## Week 3 — files, search, projects (fuzzy everything)

| Keys | What |
|---|---|
| `<leader><space>` or `<leader>ff` | find files (fuzzy) |
| `<leader>fz` | **zoxide**: jump to any project directory you have visited |
| `<leader>fr` | recent files |
| `<leader>fb` / `<leader>,` | open buffers |
| `<leader>/` or `<leader>sg` | live grep across project |
| `<leader>sw` | grep word under cursor |
| `<leader>ss` | LSP symbols in file (functions, types…) |
| `<leader>sS` | LSP symbols in workspace |
| `<leader>sk` | search keymaps · `<leader>sh` search help · `<leader>sc` command history |
| `<leader>e` | file explorer sidebar (toggle). `a` add, `d` delete, `r` rename, `?` help |
| `-` | **oil**: parent dir as an editable buffer. Rename/delete with normal editing, `:w` to apply |
| `<leader>sr` | **grug-far**: project-wide search & replace with preview |
| `<leader>sx` | replace word under cursor in this file (confirm each) |
| `<leader>H` / `<leader>h` | **harpoon**: mark file / open list. `<leader>1..4` jump to marked file |
| `Shift-h` `Shift-l` | previous / next buffer |
| `<leader>bd` | close buffer · `<leader>bo` close others |
| `Ctrl-h/j/k/l` | move between windows |
| `<leader>-` `<leader>\|` | split below / right · `<leader>wd` close window |
| `<leader>qs` | restore last session for this directory |

Inside any picker: `Ctrl-j/k` move, `Ctrl-q` send to quickfix, `Alt-i` toggle ignored, `Alt-h` toggle hidden, `Ctrl-s` / `Ctrl-v` open in split.

## Code (LSP, completion, Copilot)

| Keys | What |
|---|---|
| `gd` `gr` `gI` `gy` | go to definition / references / implementation / type definition |
| `K` | hover docs (press again to enter the window) |
| `gK` | signature help |
| `<leader>ca` | code action (quick fix, add import…) |
| `<leader>cr` | rename symbol (live preview) |
| `<leader>cR` | rename file (updates imports) |
| `<leader>co` `<leader>cM` `<leader>cu` | organize imports / add missing imports / remove unused |
| `<leader>cf` | format file · `<leader>uf` toggle format-on-save |
| `<leader>cj` | split / join block (object, array, args, JSX props) |
| `]d` `[d` | next / previous diagnostic · `<leader>cd` show it · `<leader>xx` all diagnostics (Trouble) |
| `]]` `[[` | next / previous reference of word under cursor |
| `]f` `[f` | next / previous function start |
| `Tab` | accept **Copilot** ghost text (or jump in snippet) · `Alt-]` `Alt-[` cycle suggestions |
| `Ctrl-space` | open completion menu · `Enter` accept · `Ctrl-e` dismiss |
| `<leader>aa` | Copilot Chat toggle · `<leader>aq` quick question · `<leader>ap` prompt actions |
| `<leader>ac` | **Claude Code** toggle · `<leader>as` (visual) send selection · `<leader>ay`/`<leader>an` accept/deny diff |
| `<leader>uh` | toggle inlay hints |
| `Ctrl-a` `Ctrl-x` | increment / decrement number, date, `true`↔`false`, `&&`↔`\|\|` (dial) |
| `Alt-h/j/k/l` | move line or selection (mini.move) |
| `<leader>tt` `<leader>tr` | run tests in file / nearest test (neotest) |
| `<leader>db` `<leader>dc` | debugger: breakpoint / continue |

## Git

| Keys | What |
|---|---|
| `<leader>gg` | **lazygit** (stage with space, commit with c, push with P, `?` for help) |
| `<leader>gv` | **diffview** toggle (VS Code-style side by side) |
| `<leader>gH` | file history (visual: history of selection) |
| `]h` `[h` | next / previous hunk · `<leader>ghs` stage hunk · `<leader>ghr` reset hunk · `<leader>ghp` preview |
| `<leader>gb` | blame line · `<leader>gB` open in browser |
| `<leader>gs` / `<leader>gc` | git status / commits picker |

## Editing tricks that make people fall in love

| Keys | What |
|---|---|
| `qq … q` then `Q` | record macro into `q`, replay with `Q`. Visual-select lines + `Q` runs it on each |
| `Ctrl-v` | visual block: `I` insert on all lines, `$A` append at every line end, `c` change column |
| `:s/old/new/g` | substitute in line · `:%s/old/new/gc` whole file with confirm (live preview as you type) |
| `:g/pattern/d` | delete all lines matching · `:g!/pattern/d` keep only matching · `:v/x/norm A;` |
| `:norm` | run normal-mode keys on a range, e.g. select lines then `:norm A,` |
| `"ayiw` `"ap` | yank into register `a`, paste from it · `<leader>p` yank history · `"0p` last yank · `"+` system clipboard (default here) |
| `P` (visual) | paste over selection without clobbering the register |
| `gv` | reselect last visual selection · `o` in visual swaps ends |
| `gi` | insert where you last inserted · `` `. `` jump to last change |
| `Ctrl-r =` (insert) | expression register: `Ctrl-r =2*21` inserts 42 |
| `Ctrl-w` `Ctrl-u` (insert) | delete word / line backwards |
| `~` `g??` | toggle case / rot13 (for fun) |
| `za` `zR` `zM` | toggle fold / open all / close all |
| `<leader>uz` | zen mode · `<leader>uZ` zoom buffer |
| `<leader>.` | scratch buffer (lua/markdown notes, persisted) |
| `<leader>uP` | **precognition**: show where motions land. `<leader>uH` toggle hardtime |
| `<leader>uK` | toggle the small key HUD in the corner · `<leader>uJ` next HUD page |
| `Ctrl-/` | floating terminal |
| `<leader>L` | LazyVim changelog · `:Lazy` plugins · `:Mason` LSP servers · `:LazyExtras` |

## Learn more

- `:Tutor` (30 min, do it once), then `:help user-manual` chapter by chapter.
- `:help {anything}` — e.g. `:help text-objects`, `:help registers`, `:help :g`.
- `:VimBeGood` — a game that drills relative jumps, `ciw`, and more. Five minutes a day.
- Disable hardtime (`<leader>uH`) only after it stops nagging you.
