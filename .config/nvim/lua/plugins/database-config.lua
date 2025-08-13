return {
  -- Plugin declaration
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    { "tpope/vim-dotenv", lazy = true, cmd = { "Dotenv" }, },
  },

  -- Command triggers
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },

  -- Global options
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_auto_execute_table_helpers = 1
    vim.g.db_ui_winwidth = 35
    vim.g.db_ui_default_query = 'select * from "{table}" limit 20'
    vim.g.db_ui_dotenv_variable_prefix = "DB_UI_"
    vim.g.db_ui_use_postgres_views = 1
  end,
}
