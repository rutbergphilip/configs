return {
  -- Dashboard: custom header + extra entries
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}
      opts.dashboard.preset = opts.dashboard.preset or {}
      opts.dashboard.preset.header = [[
 ██████╗ ██╗  ██╗██╗██╗     ██╗██████╗ ██╗   ██╗██╗███╗   ███╗
 ██╔══██╗██║  ██║██║██║     ██║██╔══██╗██║   ██║██║████╗ ████║
 ██████╔╝███████║██║██║     ██║██████╔╝██║   ██║██║██╔████╔██║
 ██╔═══╝ ██╔══██║██║██║     ██║██╔═══╝ ╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║     ██║  ██║██║███████╗██║██║      ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝╚═╝       ╚═══╝  ╚═╝╚═╝     ╚═╝
   Space = leader · Space u k = cheat sheet · Space u K = key HUD]]
      opts.dashboard.preset.keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "z", desc = "Zoxide Project", action = ":lua Snacks.picker.zoxide()" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        { icon = " ", key = "k", desc = "Cheat Sheet (start here)", action = ":Cheat" },
        { icon = "󰙨 ", key = "t", desc = "Interactive Tutorial", action = ":Tutor" },
        {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
        { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      }
    end,
  },

  -- Lualine: show the current macro recording + harpoon slot
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local reg = vim.fn.reg_recording()
          return reg ~= "" and ("󰑊 recording @" .. reg) or ""
        end,
        color = { fg = "#f38ba8", gui = "bold" },
      })
    end,
  },

  -- Bufferline: show buffer numbers for harpoon-style jumping with <leader>1..9
  {
    "akinsho/bufferline.nvim",
    opts = { options = { separator_style = "slant", always_show_bufferline = true } },
  },
}
