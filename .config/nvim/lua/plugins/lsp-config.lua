return {
  -- Plugin declaration
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },

  config = function()

    -- LSP capabilities setup
    local capabilities = vim.g.cmp_default_capabilities or require("cmp_nvim_lsp").default_capabilities()

    -- LSP enable helper
    local function with_capabilities(name)
      vim.lsp.enable(name)
      vim.lsp.config(name, { capabilities = capabilities })
    end

    -- Server list
    local servers = {
      "ts_ls",
      "jsonls",
      "html",
      "cssls",
      "pyright",
      "clangd",
      "yamlls",
      "tailwindcss",
      "jdtls",
    }

    -- Server setup loop
    for _, server in ipairs(servers) do
      with_capabilities(server)
    end
  end,
}
