return {
  -- Plugin declaration
  "jiaoshijie/undotree",
  dependencies = "nvim-lua/plenary.nvim",

  config = function()

    -- Plugin setup
    require("undotree").setup()
  end,
}
