return {
  -- Plugin declaration
  "rcarriga/nvim-notify",
  event = "VeryLazy",

  config = function()

    -- Core modules
    local notify = require("notify")
    vim.notify = notify

    -- Plugin setup
    notify.setup({
      render = "wrapped-default",
      timeout = 3000,
      on_open = function(win)
        local buf = vim.api.nvim_win_get_buf(win)
        vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
      end,
    })

    -- Auto command registration
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        require("notify").clear_history()
      end,
    })

    -- Telescope integration
    local ok, telescope = pcall(require, "telescope")
    if ok then
      telescope.load_extension("notify")
    end
  end,
}
