return {
  -- Plugin declaration
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },

  -- Build step
  build = function() vim.fn["mkdp#util#install"]() end,

  -- Global options
  init = function()
    vim.cmd([[
      function! OpenMarkdownPreview(url)
        execute "silent ! open -a 'Google Chrome' -n --args --new-window " . a:url
      endfunction
    ]])

    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
  end,
}
