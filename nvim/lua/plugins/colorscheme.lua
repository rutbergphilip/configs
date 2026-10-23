-- Theme: Catppuccin Mocha (LazyVim already ships catppuccin + tokyonight; this picks the default).
-- Switch at any time with <leader>uC.
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      term_colors = true,
      dim_inactive = { enabled = false },
      styles = { comments = { "italic" }, conditionals = {}, keywords = { "italic" } },
      integrations = {
        blink_cmp = true,
        snacks = true,
        which_key = true,
        harpoon = true,
        diffview = true,
        mason = true,
      },
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
}
