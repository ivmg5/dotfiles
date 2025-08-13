return {
  -- Plugin declaration
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },

  config = function()

    -- Plugin setup
    require("nvim-treesitter.configs").setup({
      ensure_installed = "all",
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
