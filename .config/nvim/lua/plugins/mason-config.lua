return {
  -- Plugin declaration
  "williamboman/mason.nvim",

  -- Build step
  build = ":MasonUpdate",

  config = function()

    -- Plugin setup
    require("mason").setup({
      ui = {
        border = "rounded",
      },
    })
  end,
}
