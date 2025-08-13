return {
  -- Plugin declaration
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()

    -- Global options
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    -- Plugin setup
    require("nvim-tree").setup({
      view = {
        width = 30,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          git_placement = "after",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = false,
            diagnostics = false,
          },
        },
      },
    })
  end,
}
