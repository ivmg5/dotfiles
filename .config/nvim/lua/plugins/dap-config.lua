return {
  -- Plugin declaration
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      { "rcarriga/nvim-dap-ui", dependencies = "nvim-neotest/nvim-nio" },
      "LiadOz/nvim-dap-repl-highlights",
    },

    config = function()

      -- Debugger manager setup
      require("mason-nvim-dap").setup({
        ensure_installed       = { "python", "codelldb" },
        automatic_installation = true,
        handlers = {
          function(source_name)
            require("mason-nvim-dap").default_setup(source_name)
          end,
        },
      })

      -- Plugin setup
      require("dapui").setup()
      require("nvim-dap-repl-highlights").setup()
    end,
  },
}