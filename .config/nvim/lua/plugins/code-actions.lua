return {
  -- Plugin declaration
  "kosayoda/nvim-lightbulb",
  event = { "BufReadPost", "BufNewFile" },

  config = function()

    -- Plugin setup
    require("nvim-lightbulb").setup({
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true },
    })
  end,
}
