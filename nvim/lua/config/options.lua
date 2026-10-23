-- Options are automatically loaded before lazy.nvim startup
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- LazyVim feature flags
vim.g.lazyvim_picker = "snacks" -- fuzzy finder: Snacks picker (fzf-like, fast, previews)
vim.g.lazyvim_prettier_needs_config = false -- format with prettier even without a .prettierrc
vim.g.autoformat = true -- format on save (toggle with <leader>uf)
vim.g.snacks_animate = true -- smooth scroll / animations

-- Editing feel
opt.scrolloff = 8 -- keep 8 lines of context above/below the cursor
opt.sidescrolloff = 12
opt.wrap = false
opt.swapfile = false -- undofile is on by default; swap files just get in the way
opt.confirm = true -- ask instead of failing on :q with unsaved changes
opt.virtualedit = "block" -- let the cursor move past line ends in visual block mode
opt.jumpoptions = "view" -- restore the view when jumping back with <C-o>

-- Visuals
opt.cursorline = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", extends = "…", precedes = "…" }
opt.winborder = "rounded" -- rounded borders on all floating windows (nvim 0.11+)
opt.pumheight = 12

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split" -- live preview of :s substitutions in a split

-- Spelling (toggle with <leader>us). Markdown/git commits enable it automatically.
opt.spelllang = { "en" }
