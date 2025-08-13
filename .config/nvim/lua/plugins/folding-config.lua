return {
  -- Plugin declaration
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  event = "VeryLazy",

  config = function()

    -- Global options
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    vim.o.foldcolumn = "auto:9"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Plugin setup
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        local name = vim.api.nvim_buf_get_name(bufnr)
        local fname = vim.fn.fnamemodify(name, ":t")
        if fname == "" or fname:match("^NvimTree_") then
          return ""
        end
        return { "treesitter", "indent" }
      end,

      -- Preview window configuration
      preview = {
        win_config = {
          border = "rounded",
          winhighlight = "Normal:Normal",
          winblend = 12,
          maxheight = 20,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "[",
          jumpBot = "]",
        },
      },
    })

    -- Sign definitions
    vim.fn.sign_define("FoldClosed", { text = "", texthl = "Folded" })
    vim.fn.sign_define("FoldOpen", { text = "", texthl = "Folded" })
    vim.fn.sign_define("FoldSeparator", { text = " ", texthl = "Folded" })
  end,
}
