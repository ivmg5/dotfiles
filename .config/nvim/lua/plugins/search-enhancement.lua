return {
  -- Plugin declaration
  "kevinhwang91/nvim-hlslens",
  event = "VeryLazy",

  config = function()

    -- Plugin setup
    require("hlslens").setup({
      auto_enable = true,
      enable_incsearch = true,
      calm_down = false,
      nearest_only = true,
      nearest_float_when = "auto",
    })

    -- Core modules
    local hlslens = require("hlslens")

    -- Search peek logic
    local function nN(char)
      local ok, winid = hlslens.nNPeekWithUFO(char)
      if ok and winid then
        vim.keymap.set("n", "<CR>", function()
          return "<Tab><CR>"
        end, { buffer = true, remap = true, expr = true })
      end
    end

    -- Key mappings
    vim.keymap.set({ "n", "x" }, "n", function() nN("n") end)
    vim.keymap.set({ "n", "x" }, "N", function() nN("N") end)
  end,
}
