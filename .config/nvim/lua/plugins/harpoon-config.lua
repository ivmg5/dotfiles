return {
  -- Plugin declaration
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },

  config = function()

    -- Core modules
    local harpoon = require("harpoon")
    local extensions = require("harpoon.extensions")
    local conf = require("telescope.config").values

    -- Plugin setup
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    })

    -- Extensions configuration
    harpoon:extend(extensions.builtins.highlight_current_file())

    -- UI behavior customization
    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-v>", function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })
      end,
    })

    -- Telescope integration
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    -- User command definitions
    vim.api.nvim_create_user_command("TelescopeHarpoon", function()
      toggle_telescope(harpoon:list())
    end, {})

    vim.api.nvim_create_user_command("HarpoonList", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, {})

    vim.api.nvim_create_user_command("HarpoonSet", function(opts)
      local index = tonumber(opts.args)
      if not index then return end
      local path = vim.api.nvim_buf_get_name(0)
      harpoon:list():replace_at(index, { value = path })
    end, {
      nargs = 1,
    })

    vim.api.nvim_create_user_command("HarpoonRemove", function(opts)
      local index = tonumber(opts.args)
      if not index then return end
      harpoon:list():remove_at(index)
    end, {
      nargs = 1,
    })
  end,
}
