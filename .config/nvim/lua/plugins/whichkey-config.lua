return {
  -- Plugin declaration
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
  },

  -- Plugin setup
  opts = {
    preset = "modern",
    plugins = {
      marks = false,
      registers = false,
      spelling = { enabled = false },
    },
    icons = {
      colors = true,
    },
    notify = true,
  },
}
