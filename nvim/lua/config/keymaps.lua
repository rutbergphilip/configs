-- Keymaps are automatically loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Press <leader>sk to search every keymap, <leader>uk for the cheat sheet.

local map = vim.keymap.set

-- Keep the cursor centered while jumping around
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "<C-f>", "<C-f>zz", { desc = "Page down (centered)" })
map("n", "<C-b>", "<C-b>zz", { desc = "Page up (centered)" })

-- J joins lines without moving the cursor
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Don't pollute the default register with empty lines (tip: in visual mode, P pastes without yanking)
map("n", "dd", function()
  return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
end, { expr = true, desc = "Delete line (blackhole if empty)" })

-- Macros: record with qq, replay with Q (and Q over a visual selection runs it on every line)
map("n", "Q", "@q", { desc = "Replay macro q" })
map("x", "Q", ":norm @q<CR>", { desc = "Replay macro q on selection" })

-- Zoxide: jump to any directory you have visited in the shell
map("n", "<leader>fz", function()
  Snacks.picker.zoxide()
end, { desc = "Zoxide (projects)" })

-- Search & replace the word under the cursor (confirm each with y/n)
map(
  "n",
  "<leader>sx",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gcI<Left><Left><Left><Left>]],
  { desc = "Replace word under cursor" }
)

-- Window resizing with arrows (LazyVim already has <C-Up/Down/Left/Right>; these are a mnemonic alias)
map("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })
