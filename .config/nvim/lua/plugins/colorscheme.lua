return {
  -- Plugin declaration
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,

  config = function()

    -- Plugin setup
    require("catppuccin").setup({
      flavour = "mocha",
      background = {
        light = "latte",
        dark = "mocha",
      },
      dim_inactive = {
        enabled = true,
      },
      default_integrations = false,
      integrations = {},
    })

    -- Colorscheme activation
    vim.cmd.colorscheme("catppuccin")
  end,
}
