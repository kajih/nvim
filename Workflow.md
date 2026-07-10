# Workflow / Keybinds

## Swedish keymap
Set via `langmap` in `settings.lua` (`ö/ä/Ö/Ä` -> `[/]/{/}`), so every `[`/`]`-based
motion below also works with `ö`/`ä`, and every `{`/`}` also works with `Ö`/`Ä`.
On top of that, `ö`/`ä` double as easy-to-reach prefix keys for a few two-char
mappings (buffers, tags, diagnostics, indentwise) - see below.

ö - [
ä - ]
Ö - {
Ä - }

## Standard
jk        - exit insert mode
H / L     - ^ / $ (start/end of line)
Q         - replay last macro (@@)
J         - join line, keep cursor in place
n / N     - next/prev search match, centered
<C-d>     - scroll down half page, centered
<C-u>     - scroll up half page, centered
<C-l>     - clear search highlight
<M-j>     - move line/selection down (reindented)
<M-k>     - move line/selection up (reindented)
<A-i>     - toggle floating terminal (FTerm)

## Splits
<leader>xv    - split vertically
<leader>xh    - split horizontally
<C-w>o        - only window (removes other splits, built-in)
<C-w>{hjkl}   - split navigation (built-in)
<leader>{hjkl}          - move focus to left/down/up/right window
<C-Up/Down/Left/Right>  - resize current window

## Buffers
[b / ]b     - previous / next buffer
öb / äb     - same (Swedish keymap)

## Tags
[t / ]t     - previous / next tag
öt / ät     - same (Swedish keymap)
<leader>tn / <leader>tp - next / previous tag (duplicate of ]t / [t)

## Diagnostics
[d / ]d     - previous / next diagnostic
öd / äd     - same (Swedish keymap)
<leader>e   - show diagnostic in a float
<leader>q   - diagnostics to quickfix list

## Indentwise (vim-indentwise)
öj  - next line with equal indent   (like `]=`, mnemonic: j = down)
ök  - previous line with equal indent (like `[=`, mnemonic: k = up)

## LSP
Native Neovim 0.11+ defaults (no extra mapping needed):
K     - hover
grr   - references
gri   - go to implementation
grn   - rename
gra   - code action
gO    - document symbols

Custom, set on LspAttach:
gd          - go to definition (Telescope)
gD          - go to declaration
<leader>D   - type definition (Telescope)
<leader>ws  - workspace symbols (Telescope)
<leader>li  - :LspInfo

## Telescope
<leader>ff  - find files
<leader>fg  - live grep
<leader>fb  - buffers
<leader>fh  - help tags

## Flash (motion plugin, replaces sneak-style jumping)
s         - flash jump (normal/visual/operator-pending)
S         - flash treesitter select (normal/visual/operator-pending)
r         - flash remote (operator-pending)
R         - flash treesitter search (operator-pending/visual)
<C-s>     - toggle flash search (command-line mode)
<C-space> - treesitter incremental selection

## Surround (mini.surround)
sa{motion}{char}  - add surround, e.g. `saiw)` `saw)`
sd{char}          - delete surround, e.g. `sd)`
sr{char}{char}    - replace surround, e.g. `sr)]`
sf / sF           - find surround to the right / left
sh                - highlight surround

## Comment
Native Neovim 0.10+ commenting, no plugin needed.
gcc - comment/uncomment current line
gc  + motion - comment/uncomment over a motion (e.g. `gcap`)

## File explorer
-  - open Oil (parent directory browser, replaces netrw)

## Harpoon
Quick navigation between project files.
<leader>pa  - add file
<C-e>       - menu toggle
<C-h>       - file 1
<C-t>       - file 2
<C-n>       - file 3
<C-s>       - file 4
<C-S-P>     - prev in list
<C-S-N>     - next in list

## Debugging (DAP)
F3          - toggle DAP UI
F5          - continue
F10         - step over
F11         - step into
F12         - step out
<leader>b   - toggle breakpoint
<leader>B   - set breakpoint (with condition prompt)
<leader>dL  - set log point
<leader>dr  - open REPL
<leader>dl  - run last debug session
<leader>dh  - hover (normal/visual)
<leader>dp  - preview (normal/visual)
<leader>df  - frames float
<leader>ds  - scopes float

Known gap: C/C++ and Rust adapters point at a hardcoded `/usr/bin/lldb-dap`,
which doesn't exist on this (Windows) machine - Go debugging (delve) works.

## Formatting
Handled automatically on save via conform.nvim (stylua for Lua).

## Notes on plugin churn
- blink.cmp tracks the `main` (v2, pre-release) branch instead of a `1.*` tag -
  expect occasional breakage until v2 stabilizes.
- Surround is provided by `mini.surround` (`sa`/`sd`/`sr`/...), not tpope's
  vim-surround (`ys`/`ds`/`cs`) - the two use different key schemes, don't mix them up.
