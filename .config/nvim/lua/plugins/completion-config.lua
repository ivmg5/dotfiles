return {
  -- Plugin declaration
  "hrsh7th/nvim-cmp",
  lazy = false,

  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp",
    "windwp/nvim-autopairs",
    "hrsh7th/cmp-cmdline",
    "rcarriga/cmp-dap",
    "kristijanhusak/vim-dadbod-completion",
    "SergioRibera/cmp-dotenv",
    "ray-x/cmp-sql",
  },

  config = function()

    -- Copilot integration setup
    pcall(function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end)
    require("copilot_cmp").setup({ fix_pairs = true })

    -- Snippet engine setup
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Core modules
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local cmp_buffer = require("cmp_buffer")
    pcall(require, "cmp_dap")

    -- Cursor context check
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      if col == 0 then return false end
      return not vim.api.nvim_get_current_line():sub(col, col):match("%s")
    end

    -- Global completion setup
    cmp.setup({
      -- Snippet expansion
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },

      -- Window appearance
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      -- Key mappings
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- Completion formatting
      formatting = {
        format = function(entry, vim_item)
          vim_item = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "…",
            symbol_map = { Copilot = "" },
          })(entry, vim_item)

          vim_item.menu = ({
            copilot   = "[COP]",
            nvim_lsp  = "[LSP]",
            luasnip   = "[SNIP]",
            path      = "[PATH]",
            buffer    = "[BUF]",
            dap       = "[DAP]",
            dotenv    = "[ENV]",
            sql       = "[SQL]",
            ["vim-dadbod-completion"] = "[DB]",
          })[entry.source.name] or ""

          return vim_item
        end,
      },

      -- Enable condition
      enabled = function()
          return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
              or require("cmp_dap").is_dap_buffer()
      end,

      -- Completion sources
      sources = {
        { name = "copilot",   group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip",  group_index = 2, option = { show_autosnippets = true } },
        { name = "path",     group_index = 2 },
        { name = "buffer",   group_index = 2 },
        { name = "dotenv", group_index = 2 },
      },

      -- Sorting configuration
      sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          function(...) return cmp_buffer:compare_locality(...) end,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })

    -- DAP-specific sources
    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
            { name = "dap" },
        },
    })

    -- SQL-specific sources
    cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "sql" },
        { name = "buffer" },
      },
    })

    -- Autopair integration
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- LSP capabilities
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.g.cmp_default_capabilities = capabilities

    -- Search mode completion
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Command-line completion
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
            treat_trailing_slash = true,
          },
        },
      }),
    })
  end,
}
