-- Load all required modules used across keybindings
local wk = require("which-key")
local dropbar_api = require("dropbar.api")
local dap = require("dap")
local dapui = require("dapui")
local telescope_builtin = require("telescope.builtin")
local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
local telescope = require("telescope")
local dap_ext = require("telescope").extensions.dap
local ufo = require("ufo")
local neotest = require("neotest")
local undotree = require("undotree")

-- Code Navigation (Dropbar & Aerial)
wk.add({
  { "<leader>n", group = "Code Navigation" },
  { "<leader>nc", dropbar_api.pick, desc = "Select part of the current code path", mode = "n", },
  { "<leader>ns", dropbar_api.goto_context_start, desc = "Go to start of current section", mode = "n", },
  { "<leader>nl", dropbar_api.select_next_context, desc = "Choose another section at same level", mode = "n", },
  { "<leader>nt", "<cmd>AerialToggle!<cr>", desc = "Show or hide code structure view", mode = "n" },
  { "<leader>nn", "<cmd>AerialNext<cr>", desc = "Jump to next section", mode = "n" },
  { "<leader>np", "<cmd>AerialPrev<cr>", desc = "Jump to previous section", mode = "n" },
  { "<leader>nf", "<cmd>AerialNavToggle<cr>", desc = "Show floating code structure view", mode = "n" },
})

-- Code Suggestions (LSP)
wk.add({
  { "<leader>l", group = "Code Suggestions" },
  { "<leader>ll", function() vim.lsp.buf.code_action() end, desc = "View suggested actions", mode = "n", },
})

-- Debugging (DAP + DAP UI)
wk.add({
  { "<leader>d", group = "Code Debugging" },
  { "<leader>dc", dap.continue, desc = "Start or resume debugging", mode = "n" },
  { "<leader>db", dap.toggle_breakpoint, desc = "Set breakpoint", mode = "n" },
  { "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Set conditional breakpoint", mode = "n" },
  { "<leader>dn", dap.step_over, desc = "Step over current line", mode = "n" },
  { "<leader>di", dap.step_into, desc = "Step into function", mode = "n" },
  { "<leader>do", dap.step_out, desc = "Step out of function", mode = "n" },
  { "<leader>dt", dapui.toggle, desc = "Show or hide debugger panel", mode = "n" },
  { "<leader>dv", dapui.eval, desc = "Check variable value", mode = { "n", "v" } },
  { "<leader>dq", dap.terminate, desc = "Stop debugging", mode = "n" },
  { "<leader>dl", function() dap.set_breakpoint(nil, nil, vim.fn.input("Log message: ")) end, desc = "Set breakpoint with log message", mode = "n" },
  { "<leader>dk", dap.clear_breakpoints, desc = "Remove all breakpoints", mode = "n" },
})

-- Code Folding (UFO + Vim)
wk.add({
  { "<leader>f", group = "Code Folding" },
  { "<leader>fo", function() ufo.openAllFolds() end, desc = "Unfold all code sections", mode = "n" },
  { "<leader>fc", function() ufo.closeAllFolds() end, desc = "Fold all code sections", mode = "n" },
  { "<leader>fO", function() vim.cmd("normal! zO") end, desc = "Unfold current section", mode = "n" },
  { "<leader>fC", function() vim.cmd("normal! zC") end, desc = "Fold current section", mode = "n" },
  { "<leader>ff", function() local winid = ufo.peekFoldedLinesUnderCursor() if not winid then vim.lsp.buf.hover() end end, desc = "Preview folded section", mode = "n" },
})

-- Code Issues (Trouble)
wk.add({
  { "<leader>x", group = "Code Problems" },
  { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Show or hide all code issues" },
  { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Show or hide issues in this file" },
})

-- Testing (Neotest)
wk.add({
  { "<leader>r", group = "Code Testing" },
  { "<leader>rn", function() neotest.run.run() end, desc = "Run nearest test" },
  { "<leader>ra", function() neotest.run.run(vim.fn.expand("%")) end, desc = "Run all tests in file" },
  { "<leader>rq", function() neotest.run.stop() end, desc = "Stop running tests" },
  { "<leader>rt", function() neotest.summary.toggle() end, desc = "Show or hide test summary" },
  { "<leader>ro", function() neotest.output.open({ enter = true }) end, desc = "Show result of current test" },
  { "<leader>rp", function() neotest.output_panel.toggle() end, desc = "Show all test results" },
  { "<leader>rj", function() neotest.run.run({ jestCommand = "jest --watch" }) end, desc = "Run Jest in watch mode" },
})

-- Tab & Buffer Management (Bufferline)
wk.add({
  { "<leader>b", group = "Tabs" },
  { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next tab", mode = "n" },
  { "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous tab", mode = "n" },
  { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other tabs", mode = "n" },
  { "<leader>bd", "<cmd>bdelete<cr>", desc = "Close this tab", mode = "n" },
  { "<leader>bN", "<cmd>BufferLineMoveNext<cr>", desc = "Move tab right", mode = "n" },
  { "<leader>bP", "<cmd>BufferLineMovePrev<cr>", desc = "Move tab left", mode = "n" },
  { "<leader>bf", "<cmd>BufferLinePick<cr>", desc = "Choose tab", mode = "n" },
  { "<leader>bi", "<cmd>BufferLineTogglePin<cr>", desc = "Pin or unpin this tab", mode = "n" },
  { "<leader>be", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort tabs by file type", mode = "n" },
  { "<leader>bs", "<cmd>BufferLineSortByDirectory<cr>", desc = "Sort tabs by folder", mode = "n" },
})

-- Database Tools (DBUI + .env)
wk.add({
  { "<leader>v", group = "Database Tools" },
  { "<leader>vo", "<cmd>DBUI<cr>", desc = "Open database explorer", mode = "n" },
  { "<leader>vt", "<cmd>DBUIToggle<cr>", desc = "Show or hide database explorer", mode = "n" },
  { "<leader>va", "<cmd>DBUIAddConnection<cr>", desc = "Add new database connection", mode = "n" },
  { "<leader>vf", "<cmd>DBUIFindBuffer<cr>", desc = "Find open database tab", mode = "n" },
  { "<leader>vl", function() vim.cmd("Dotenv .env"); local env_file = vim.fn.getcwd() .. "/.env"; local lines = vim.fn.readfile(env_file); local found = {}; for _, line in ipairs(lines) do local key = line:match("^%s*([A-Z0-9_]+)%s*="); if key and key:match("^DB_UI_") then local val = vim.fn["DotenvGet"](key); if val and val ~= "" and val ~= vim.NIL then table.insert(found, "🔗 " .. key .. " = " .. val) end end end; if #found > 0 then vim.notify(table.concat(found, "\n"), vim.log.levels.INFO, { title = ".env loaded" }) else vim.notify("No DB_UI_* variables found in .env", vim.log.levels.WARN, { title = ".env load" }) end end, desc = "Load settings from .env", mode = "n" },
})

-- File Explorer (NvimTree)
wk.add({
  { "<leader>e", group = "File Explorer" },
  { "<leader>et", "<cmd>NvimTreeToggle<cr>", desc = "Show or hide file explorer", mode = "n" },
  { "<leader>ef", "<cmd>NvimTreeFocus<cr>", desc = "Jump to file in explorer", mode = "n" },
  { "<leader>ec", "<cmd>NvimTreeCollapse<cr>", desc = "Collapse all folders in file explorer", mode = "n" },
  { "<leader>ed", "<cmd>lua require('nvim-tree.api').fs.create()<cr>", desc = "Create file or directory", mode = "n" },
  { "<leader>er", "<cmd>lua require('nvim-tree.api').fs.rename_node()<cr>", desc = "Rename file or directory", mode = "n" },
  { "<leader>ex", "<cmd>lua require('nvim-tree.api').fs.cut()<cr>", desc = "Cut file", mode = "n" },
  { "<leader>ey", "<cmd>lua require('nvim-tree.api').fs.copy.node()<cr>", desc = "Copy file", mode = "n" },
  { "<leader>ep", "<cmd>lua require('nvim-tree.api').fs.paste()<cr>", desc = "Paste file", mode = "n" },
  { "<leader>ex", "<cmd>lua require('nvim-tree.api').fs.remove()<CR>", desc = "Delete file", mode = "n" },
  { "<leader>eX", "<cmd>lua require('nvim-tree.api').fs.remove()<CR>", desc = "Delete directory", mode = "n" },
})

-- Search Tools (Telescope + LGA + DAP)
wk.add({
  { "<leader>s", group = "Search" },
  { "<leader>sf", telescope_builtin.find_files, desc = "Search files in project" },
  { "<leader>st", telescope.extensions.live_grep_args.live_grep_args, desc = "Search text in project" },
  { "<leader>sF", function() telescope_builtin.find_files({ hidden = true, no_ignore = true, case_sensitive = true }) end, desc = "Search all files (include hidden)", mode = "n" },
  { "<leader>sT", function() telescope_builtin.live_grep({ additional_args = function() return { "--hidden", "--no-ignore" } end }) end, desc = "Search all text (include hidden)", mode = "n" },
  { "<leader>sg", telescope_builtin.git_files, desc = "Search files in Git repo" },
  { "<leader>so", telescope_builtin.buffers, desc = "Search open files" },
  { "<leader>sr", telescope_builtin.oldfiles, desc = "Search recent files" },
  { "<leader>sw", lga_shortcuts.grep_word_under_cursor, desc = "Search word under cursor" },
  { "<leader>sh", "<cmd>TelescopeHarpoon<cr>", desc = "Search bookmarks" },
  { "<leader>sn", "<cmd>Telescope notify<cr>", desc = "Search notification history" },
  { "<leader>sd", dap_ext.commands, desc = "Search debug commands" },
  { "<leader>sb", dap_ext.list_breakpoints, desc = "Search debug breakpoints" },
  { "<leader>sv", dap_ext.variables, desc = "Search debug variables" },
  { "<leader>ss", dap_ext.frames, desc = "Search function call history" },
})

-- Terminal Toggle (ToggleTerm)
wk.add({
    { "<leader>t", group = "Terminal" },
    { "<leader>tt", "<cmd>1ToggleTerm direction=horizontal<cr>", desc = "Open or close terminal" },
})

-- Undo Tree (Undotree)
wk.add({
  { "<leader>u", group = "Undo & Redo" },
  { "<leader>uu", function() undotree.toggle() end, desc = "Show undo history", mode = "n" },
  { "<leader>un", "u", desc = "Undo", mode = { "n", "i" } },
  { "<leader>up", "<C-r>", desc = "Redo", mode = { "n", "i" } },
})

-- Window Management
wk.add({
  { "<leader>w", group = "Window Management" },
  { "<leader>wh", "<C-w>h", desc = "Move to left split", mode = "n" },
  { "<leader>wj", "<C-w>j", desc = "Move to below split", mode = "n" },
  { "<leader>wk", "<C-w>k", desc = "Move to above split", mode = "n" },
  { "<leader>wl", "<C-w>l", desc = "Move to right split", mode = "n" },
  { "<leader>wv", "<cmd>vsplit<CR>", desc = "Open vertical split", mode = "n" },
})

-- Clipboard
wk.add({
  { "<leader>y", group = "Clipboard" },
  { "<leader>ya", "ggVG\"+y", desc = "Copy entire file to clipboard", mode = "n" },
  { "<leader>yy", '"+y', desc = "Copy to system clipboard", mode = { "n", "v" } },
  { "<leader>yd", '"+d', desc = "Cut to system clipboard", mode = { "n", "v" } },
  { "<leader>yp", '"+gP', desc = "Paste from system clipboard", mode = { "n", "v" } },
  { "<leader>yc", function() vim.fn.setreg("+", vim.fn.expand("%:p")); vim.notify("Copied absolute path to clipboard") end, desc = "Copy absolute file path", mode = "n" },
  { "<leader>yr", function() vim.fn.setreg("+", vim.fn.expand("%")); vim.notify("Copied relative path to clipboard") end, desc = "Copy relative file path", mode = "n" },
  { "<leader>yx", "ggdG", desc = "Delete entire buffer content", mode = "n" },
})

-- General
wk.add({
  { "<leader>g", group = "General" },
  { "<leader>gh", "<cmd>noh<CR>", desc = "Clear search highlights", mode = "n" },
  { "<leader>gR", function() local old,new=vim.fn.input("Find: "),vim.fn.input("Replace with: ");vim.cmd("args **/*.*");vim.cmd(string.format([[argdo %%s/%s/%s/ge | update]],old,new));vim.notify("Global replacement completed.", vim.log.levels.INFO) end, desc = "Global text replacement", mode = "n" },
  { "<leader>gr", function() vim.lsp.buf.rename() end, desc = "Rename symbol with LSP", mode = "n" },
})
