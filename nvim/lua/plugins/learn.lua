-- Training wheels for learning Vim motions. Both can be toggled; remove this file when you no longer need them.
return {
  -- Precognition: shows where w, b, e, ^, $, {, } etc. would land — great for internalising motions.
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>uP",
        function()
          require("precognition").toggle()
        end,
        desc = "Toggle Precognition (motion hints)",
      },
      {
        "<leader>up",
        function()
          require("precognition").peek()
        end,
        desc = "Peek motion hints once",
      },
    },
    opts = { startVisible = false, showBlankVirtLine = false },
  },

  -- Hardtime: nags when you spam hjkl/arrows and suggests the better motion. "hint" mode never blocks you.
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = "VeryLazy",
    keys = {
      { "<leader>uH", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime (habit coach)" },
      { "<leader>uR", "<cmd>Hardtime report<cr>", desc = "Hardtime report" },
    },
    opts = {
      restriction_mode = "hint",
      max_count = 4,
      disable_mouse = false,
      disabled_filetypes = {
        "qf",
        "netrw",
        "lazy",
        "mason",
        "oil",
        "snacks_dashboard",
        "snacks_picker_input",
        "snacks_picker_list",
        "snacks_terminal",
        "undotree",
        "DiffviewFiles",
        "help",
        "TelescopePrompt",
        "neo-tree",
        "trouble",
        "noice",
        "copilot-chat",
        "harpoon",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
        "dap-repl",
      },
    },
  },

  -- VimBeGood: a game that drills motions. :VimBeGood
  { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
}
