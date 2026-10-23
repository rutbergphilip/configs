-- Autocmds are automatically loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Pressing o/O on a comment line should not start a new comment line
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("no_comment_continue"),
  callback = function()
    vim.opt_local.formatoptions:remove({ "o" })
  end,
})

-- Treat .env* files as sh for highlighting (no LSP noise)
vim.filetype.add({
  pattern = { ["%.env%.[%w_.-]+"] = "sh" },
})

-- Disable format-on-save and diagnostics in huge files
vim.api.nvim_create_autocmd("BufReadPre", {
  group = augroup("bigfile"),
  callback = function(ev)
    local ok, stats = pcall((vim.uv or vim.loop).fs_stat, ev.match)
    if ok and stats and stats.size > 1024 * 1024 then
      vim.b[ev.buf].autoformat = false
    end
  end,
})
