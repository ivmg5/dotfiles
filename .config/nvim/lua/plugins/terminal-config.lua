return {
  -- Plugin declaration
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",

  -- Plugin setup
  opts = {
    size = 15,
    open_mapping = nil,
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
}
