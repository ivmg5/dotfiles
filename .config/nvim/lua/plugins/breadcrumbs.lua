return {
  -- Plugin declaration
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
  },

  config = function()

    -- Plugin setup
    require("dropbar").setup()
  end,
}
