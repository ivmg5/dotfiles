return {
  -- Plugin declaration
  "nvim-neotest/neotest",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-jest",
    "alfaix/neotest-gtest",
  },

  config = function()

    -- Plugin setup
    require("neotest").setup({
      discovery = {
        enabled = false,
      },

      -- Adapter configuration
      adapters = {
        require("neotest-python")({
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
          python = vim.fn.expand("$HOME/.pyenv/versions/nvim/bin/python"),
          pytest_discover_instances = true,
        }),

        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
          jest_test_discovery = false,
        }),

        require("neotest-gtest").setup({
          root = require("neotest.lib").files.match_root_pattern(
            "compile_commands.json",
            "compile_flags.txt",
            "WORKSPACE",
            ".clangd",
            "init.lua",
            "init.vim",
            "build",
            ".git"
          ),
        }),
      },
    })
  end,
}
