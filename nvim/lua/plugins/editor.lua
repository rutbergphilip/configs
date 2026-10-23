return {
  -- Oil: edit the filesystem like a buffer. Press - to open the parent dir, edit names, :w to apply.
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    cmd = "Oil",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" },
      {
        "<leader>-",
        function()
          require("oil").toggle_float()
        end,
        desc = "Oil (float)",
      },
    },
    opts = {
      default_file_explorer = false, -- keep snacks explorer as <leader>e; oil is the keyboard-first alternative
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true, natural_order = true },
      float = { padding = 4, max_width = 120, max_height = 40 },
      keymaps = {
        ["q"] = "actions.close",
        ["<C-h>"] = false, -- keep window navigation
        ["<C-l>"] = false,
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-v>"] = { "actions.select", opts = { horizontal = true } },
        ["gy"] = "actions.yank_entry",
      },
    },
  },

  -- TreeSJ: split/join objects, arrays, arguments, JSX props with one key
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>cj",
        function()
          require("treesj").toggle()
        end,
        desc = "Split/Join block (treesj)",
      },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  -- Undotree: visual undo history (branches!). u / <C-r> are linear; this is the full tree.
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Undotree" } },
    init = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_ShortIndicators = 1
    end,
  },

  -- Flash: s + 2 chars jumps anywhere on screen. Also enable it inside / search and f/t motions.
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = { enabled = true },
        char = { jump_labels = true },
      },
    },
  },

  -- Snacks tweaks: zoxide on the dashboard, bigger picker previews, scratch buffers
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = { hidden = true },
          grep = { hidden = true },
          explorer = { hidden = true },
        },
      },
      scroll = { enabled = true },
      zen = { toggles = { dim = true } },
    },
  },
}
