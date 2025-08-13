return {
  -- Plugin declaration
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",

  config = function()

    -- Global options
    vim.opt.termguicolors = true

    -- Plugin setup
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = (level == "error" and " ")
                    or (level == "warning" and " ")
                    or " "
          return " " .. icon .. count
        end,
        persist_buffer_sort = false,
      },
    })
  end,
}
