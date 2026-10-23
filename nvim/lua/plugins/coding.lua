return {
  -- LSP: VS Code-like diagnostics, inlay hints off by default (toggle with <leader>uh)
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      codelens = { enabled = false },
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
      },
      servers = {
        vtsls = {
          settings = {
            typescript = {
              preferences = { importModuleSpecifier = "non-relative" },
              updateImportsOnFileMove = { enabled = "always" },
              suggest = { completeFunctionCalls = true },
            },
          },
        },
      },
    },
  },

  -- Completion: VS Code feel — ghost text, docs auto-open, <CR> accepts, Tab accepts Copilot ghost text
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = { enabled = true },
        documentation = { auto_show = true, auto_show_delay_ms = 150 },
        list = { selection = { preselect = true, auto_insert = false } },
        menu = { draw = { treesitter = { "lsp" } } },
      },
      signature = { enabled = true },
    },
  },

  -- Copilot: inline ghost-text suggestions. Tab accepts, <M-]> / <M-[> cycle. Run :Copilot auth once.
  -- On machines without Copilot, `export NVIM_NO_COPILOT=1` skips Copilot and Copilot Chat entirely.
  {
    "zbirenbaum/copilot.lua",
    enabled = not vim.env.NVIM_NO_COPILOT,
    opts = {
      suggestion = { auto_trigger = true, debounce = 75 },
      filetypes = { yaml = true, markdown = true, gitcommit = true, ["*"] = true },
    },
  },

  -- Claude Code: the extra binds <leader>aa/<leader>ad for accept/deny diff, which collides with Copilot Chat.
  -- Move those to <leader>ay (yes) / <leader>an (no).
  {
    "coder/claudecode.nvim",
    keys = function(_, keys)
      keys = vim.tbl_filter(function(k)
        return k[1] ~= "<leader>aa" and k[1] ~= "<leader>ad"
      end, keys)
      vim.list_extend(keys, {
        { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: accept diff" },
        { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude: deny diff" },
      })
      return keys
    end,
  },

  -- Copilot Chat: <leader>aa toggle, <leader>ax clear, <leader>aq quick question (set by the extra)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = not vim.env.NVIM_NO_COPILOT,
    opts = { model = "gpt-4.1", window = { layout = "vertical", width = 0.4 } },
  },

  -- Extra treesitter parsers / tools handled by the lang extras; add a few nice-to-haves
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "regex", "http", "graphql", "css", "scss", "gitignore", "diff", "sql" } },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "stylua", "shfmt", "eslint-lsp", "css-lsp", "html-lsp", "emmet-language-server" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},
        html = {},
        emmet_language_server = { filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" } },
      },
    },
  },

  -- which-key: show the key popup fast (beginners should see it almost immediately)
  {
    "folke/which-key.nvim",
    opts = {
      delay = function(ctx)
        return ctx.plugin and 0 or 100
      end,
      spec = {
        { "<leader>uk", desc = "Cheat sheet" },
      },
    },
  },

  -- package.json: shows latest versions inline, lets you update/delete deps from the editor
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    event = { "BufRead package.json" },
    opts = { package_manager = "pnpm", hide_up_to_date = true },
    keys = {
      {
        "<leader>cps",
        function()
          require("package-info").show()
        end,
        desc = "package.json: show versions",
        ft = "json",
      },
      {
        "<leader>cpu",
        function()
          require("package-info").update()
        end,
        desc = "package.json: update dep",
        ft = "json",
      },
      {
        "<leader>cpd",
        function()
          require("package-info").delete()
        end,
        desc = "package.json: delete dep",
        ft = "json",
      },
      {
        "<leader>cpi",
        function()
          require("package-info").install()
        end,
        desc = "package.json: install dep",
        ft = "json",
      },
      {
        "<leader>cpv",
        function()
          require("package-info").change_version()
        end,
        desc = "package.json: change version",
        ft = "json",
      },
    },
  },
}
