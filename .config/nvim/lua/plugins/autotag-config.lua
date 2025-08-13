return {
  -- Plugin declaration
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },

  config = function()

    -- Plugin setup
    require("nvim-ts-autotag").setup({
      opts = {
        enable_rename = true,
        enable_close_on_slash = true,
      },
    })
  end,
}
