return {
  -- Plugin declaration
  "nvim-tree/nvim-web-devicons",
  lazy = false,

  config = function()

    -- Plugin setup
    require("nvim-web-devicons").setup({
      default = true,
      strict = true,
      color_icons = true,
    })
  end,
}
