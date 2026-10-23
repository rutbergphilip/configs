-- Learning helpers: the big cheat sheet (<leader>uk / :Cheat) and the tiny always-on key HUD (<leader>uK).
local function cheatsheet()
  local path = vim.fn.stdpath("config") .. "/CHEATSHEET.md"
  Snacks.win({
    text = vim.fn.readfile(path), -- scratch buffer, not the file itself: no linting, no LSP, no accidental edits
    width = 0.8,
    height = 0.85,
    border = "rounded",
    title = " Neovim Cheat Sheet  (q to close) ",
    title_pos = "center",
    bo = { filetype = "markdown", buftype = "nofile", bufhidden = "wipe", modifiable = false },
    wo = { wrap = true, linebreak = true, conceallevel = 2, spell = false, number = false, relativenumber = false },
    keys = { q = "close", ["<esc>"] = "close" },
    on_buf = function(self)
      vim.diagnostic.enable(false, { bufnr = self.buf })
    end,
  })
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>uk", cheatsheet, desc = "Cheat sheet" },
    },
    init = function()
      vim.api.nvim_create_user_command("Cheat", cheatsheet, { desc = "Open the Neovim cheat sheet" })
      LazyVim.on_very_lazy(function()
        if #vim.api.nvim_list_uis() > 0 then
          require("hud").setup()
        end
      end)
    end,
  },
}
