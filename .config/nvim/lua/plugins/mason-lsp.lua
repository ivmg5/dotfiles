return {
  -- Plugin declaration
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },

  config = function()

    -- Plugin setup
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls",
        "jsonls",
        "html",
        "cssls",
        "pyright",
        "clangd",
        "yamlls",
        "tailwindcss",
        "jdtls",
      },
      automatic_enable = false,
    })
  end,
}
