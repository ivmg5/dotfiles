return {
  -- Plugin declaration
  "folke/trouble.nvim",
  cmd = "Trouble",
  event = "BufReadPost",

  config = function()

    -- Plugin setup
    require("trouble").setup({
      auto_preview = false,
      win = {
        type = "split",
        position = "bottom",
        relative = "win",
      },
      preview = {
        type = "main",
      },
    })
  end,
}
