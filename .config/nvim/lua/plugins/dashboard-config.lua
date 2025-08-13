return {
  -- Plugin declaration
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()

    -- Core modules
    local dashboard = require("alpha.themes.dashboard")

    -- Header definition
    dashboard.section.header.val = {
      " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
      " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
      " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
      " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
      " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
    }

    -- Buttons definition
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", "<cmd>ene <CR>"),
      dashboard.button("SPC f f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC f h", "  Recently opened files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("SPC l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("SPC m", "  Mason", "<cmd>Mason<CR>"),
      dashboard.button("SPC t t", "🌲  Treesitter Modules", "<cmd>TSModuleInfo<CR>"),
      dashboard.button("q", "  Quit Neovim", "<cmd>qa<CR>"),
    }

    -- Footer definition
    dashboard.section.footer.val = function()
      return os.date("📅 %A, %d %B %Y")
    end

    -- Plugin setup
    require("alpha").setup(dashboard.config)
  end,
}
