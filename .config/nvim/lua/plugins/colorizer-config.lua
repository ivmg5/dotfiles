return {
  -- Plugin declaration
  "norcalli/nvim-colorizer.lua",
  event = "VeryLazy",

  config = function()

    -- Plugin setup
    require("colorizer").setup({
      "css",
      "javascript",
      html = { mode = "background" },
    })
  end,
}
