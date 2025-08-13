return {
  -- Plugin declaration
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",

  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "nvim-telescope/telescope-dap.nvim" },
  },

  config = function()

    -- Core modules
    local telescope = require("telescope")
    local lga_actions = require("telescope-live-grep-args.actions")

    -- Telescope setup
    telescope.setup({
      defaults = {
        layout_config = {
          horizontal = {
            preview_width = 0.55,
            results_width = 0.45,
          },
        },
      },

      -- Extensions configuration
      extensions = {
        fzf = {
          override_generic_sorter = true,
          override_file_sorter = true,
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-k>"] = lga_actions.quote_prompt(),
              ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              ["<C-space>"] = lga_actions.to_fuzzy_refine,
            },
          },
        },
      },
    })

    -- Extensions loading
    telescope.load_extension("fzf")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("dap")
  end,
}
