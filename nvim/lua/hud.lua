-- Tiny always-on key HUD in the bottom-right corner. Toggle with <leader>uK.
-- Edit the `pages` table below to change what it shows; <leader>uJ cycles pages.
local M = {}

local state_file = vim.fn.stdpath("state") .. "/cheat_hud_off"
local win ---@type snacks.win?
local page = 1
local rendered_page ---@type number?

-- Each line is { key, description, key, description }. Keep keys <= 9 chars, descriptions <= 12.
M.pages = {
  {
    title = " essentials ",
    { "Spc Spc", "find file", "Spc /", "grep" },
    { "Spc fz", "project (z)", "Spc e", "explorer" },
    { "s + 2ch", "flash jump", "-", "oil dir" },
    { "gd  gr", "def / refs", "K", "hover docs" },
    { "Spc ca", "code action", "Spc cr", "rename" },
    { "]d  [d", "next diag", "Spc xx", "all diags" },
    { "Spc gg", "lazygit", "Spc gv", "diffview" },
    { "Spc H/h", "harpoon", "S-h S-l", "buffers" },
    { "Tab", "copilot ok", "Spc aa", "chat" },
    { "Spc uk", "cheatsheet", "Spc uJ", "next page" },
  },
  {
    title = " motions ",
    { "w b e", "word", "W B E", "WORD" },
    { "0 ^ $", "line", "gg G", "file" },
    { "{ }", "paragraph", "%", "bracket" },
    { "f t ; ,", "char", "* #", "word srch" },
    { "C-d C-u", "half page", "zz zt", "center/top" },
    { "C-o C-i", "jump back", "gi", "last insert" },
    { "u C-r", "undo redo", ".", "repeat" },
    { "qq .. q", "record", "Q", "replay" },
    { "Spc uP", "hints", "Spc uJ", "next page" },
  },
  {
    title = " text objects ",
    { "ciw", "chg word", "daw", "del word" },
    { 'ci"', "in quotes", "da(", "arnd parens" },
    { "cit", "in tag", "vi{", "in braces" },
    { "yif", "function", "dac", "class" },
    { "cia", "argument", "vii", "indent" },
    { 'gsaiw"', "surround", 'gsd"', "unsurround" },
    { "gcc", "comment", "Spc cj", "split/join" },
    { ">ap", "indent par", "=i{", "reindent" },
    { "C-a C-x", "inc / dec", "Spc uJ", "next page" },
  },
}

local function lines_for(p)
  local out, hl = {}, {}
  for i, row in ipairs(p) do
    local k1, d1, k2, d2 = row[1], row[2], row[3] or "", row[4] or ""
    local line = string.format(" %-9s %-12s %-9s %-12s", k1, d1, k2, d2)
    out[#out + 1] = line
    hl[#hl + 1] = { i - 1, 1, 1 + #k1 }
    if k2 ~= "" then
      hl[#hl + 1] = { i - 1, 24, 24 + #k2 }
    end
  end
  return out, hl
end

local ns = vim.api.nvim_create_namespace("cheat_hud")

local function render()
  if not (win and win:valid()) then
    return
  end
  local p = M.pages[page]
  local lines, hl = lines_for(p)
  vim.bo[win.buf].modifiable = true
  vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, lines)
  vim.bo[win.buf].modifiable = false
  vim.api.nvim_buf_clear_namespace(win.buf, ns, 0, -1)
  for _, h in ipairs(hl) do
    vim.api.nvim_buf_set_extmark(win.buf, ns, h[1], h[2], { end_col = h[3], hl_group = "Special" })
  end
  win.opts.title = p.title .. string.format("%d/%d ", page, #M.pages)
  win.opts.height = #lines
  win:update()
  rendered_page = page
end

function M.enabled()
  return vim.uv.fs_stat(state_file) == nil
end

local function should_show()
  if not M.enabled() then
    return false
  end
  if vim.o.columns < 110 or vim.o.lines < 25 then
    return false
  end
  local ft = vim.bo.filetype
  if ft == "lazy" or ft == "mason" then
    return false
  end
  return true
end

function M.show()
  if win and win:valid() then
    if rendered_page ~= page then
      render()
    end
    return
  end
  win = Snacks.win({
    relative = "editor",
    position = "float",
    width = 47,
    height = #M.pages[page],
    row = -2, -- 2 rows up from the bottom (above the statusline / cmdline)
    col = -1,
    border = "rounded",
    title = M.pages[page].title,
    title_pos = "center",
    enter = false,
    focusable = false,
    backdrop = false,
    resize = true,
    zindex = 20,
    bo = { filetype = "cheat_hud", buftype = "nofile", bufhidden = "wipe", buflisted = false, modifiable = false },
    wo = {
      winblend = 10,
      wrap = false,
      cursorline = false,
      number = false,
      relativenumber = false,
      signcolumn = "no",
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:Comment,FloatTitle:Title",
    },
  })
  render()
end

function M.hide()
  if win and win:valid() then
    win:close()
  end
  win = nil
end

function M.refresh()
  if should_show() then
    M.show()
  else
    M.hide()
  end
end

function M.set(enabled)
  if enabled then
    pcall(os.remove, state_file)
  else
    local f = io.open(state_file, "w")
    if f then
      f:close()
    end
  end
  M.refresh()
end

function M.next_page()
  page = page % #M.pages + 1
  if M.enabled() then
    M.show()
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("cheat_hud", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "FileType", "VimResized", "TabEnter" }, {
    group = group,
    callback = function(ev)
      -- ignore events caused by the HUD's own buffer, otherwise refresh -> render -> FileType -> refresh loops forever
      if ev.buf and vim.api.nvim_buf_is_valid(ev.buf) and vim.bo[ev.buf].filetype == "cheat_hud" then
        return
      end
      vim.schedule(M.refresh)
    end,
  })
  Snacks.toggle({
    name = "Key HUD",
    get = M.enabled,
    set = M.set,
  }):map("<leader>uK")
  vim.keymap.set("n", "<leader>uJ", M.next_page, { desc = "Key HUD next page" })
  M.refresh()
end

return M
