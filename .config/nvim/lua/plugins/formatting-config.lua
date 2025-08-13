return {
  -- Plugin declaration
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
  },

  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "nvimtools/none-ls.nvim",
    },

    config = function()

      -- Core modules
      local null_ls = require("null-ls")
      local mason_null_ls = require("mason-null-ls")
      local augroup = vim.api.nvim_create_augroup("LspAutoFormat", {})

      -- Format-on-save setup
      local function on_attach(client, bufnr)
        if not client.supports_method("textDocument/formatting") then return end
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            local used = {}
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function(c)
                local ok = c.name == "null-ls"
                if ok then table.insert(used, c.name) end
                return ok
              end,
            })
            if #used > 0 then
              vim.schedule(function()
                vim.notify("Formatted by: " .. table.concat(used, ", "))
              end)
            else
              vim.schedule(function()
                vim.notify("No formatter responded", vim.log.levels.WARN)
              end)
            end
          end,
        })
      end

      -- Formatter sources
      null_ls.setup({
        on_attach = on_attach,
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.clang_format.with({
            filetypes = { "c", "cpp", "cs" },
          }),
          null_ls.builtins.formatting.google_java_format,
        },
      })

      -- Formatter manager setup
      mason_null_ls.setup({
        ensure_installed = {
          "prettier",
          "black",
          "clang-format",
          "google-java-format",
        },
        automatic_installation = true,
      })
    end,
  },
}
