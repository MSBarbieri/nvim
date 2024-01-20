return function(hydra)
  hydra({
    name = "Code",
    hint = [[
                 Code
----------------------
 _a_:            Action
 _c_:    Signature Help
 _e_:          Quickfix
 _h_:  Prev Diagnostics
 _l_:  Next Diagnostics
 _,_:   Format Document
 _r_:            Rename
 _._ | _d_:   Diagnostics
 _$_:          Lsp Info
 _z_:          Zen Mode
 _/_:          cheat.sh
----------------------
 _<Esc>_ | _q_:      exit
    ]],
    config = {
      color = 'teal',
      invoke_on_body = true,
      timeout = true,
      hint = {
        type = "window",
        position = "bottom-right",
        border = "rounded",
      },
    },
    mode = { 'n', 'v', 'x' },
    body = '<leader>c',
    heads = {
      { "a", vim.lsp.buf.code_action,              { desc = "Action" } },
      { "c", vim.lsp.buf.signature_help,           { desc = "Signature Help" } },
      { "e", vim.diagnostic.setloclist,            { desc = "Quickfix" } },
      { "h", vim.diagnostic.goto_prev,             { desc = "Prev Diagnostics", exit = false } },
      { "l", vim.diagnostic.goto_next,             { desc = "Next Diagnostics", exit = false } },
      { ",", require("plugins.lsp.format").format, { desc = "Format Document" } },
      { "r", "<cmd>IncRename <cr>",                { desc = "Incremental Rename" } },
      { ".", vim.diagnostic.open_float,            { desc = "Line Diagnostics" } },
      { "d", vim.diagnostic.open_float,            { desc = "Line Diagnostics" } },
      { "$", "<cmd>LspInfo<cr>",                   { desc = "Lsp Info" } },
      { "z", require("zen-mode").toggle,           { desc = "Zen Mode" } },
      { "/", function()
        local lang = vim.bo.filetype
        vim.api.nvim_command(":CheatWithoutComments " .. lang)
      end, { desc = "cheat.sh" } },
      { 'q',     nil, { desc = 'exit' } },
      { '<Esc>', nil, { desc = 'exit' } },
    }
  })
  -- map("n", "<leader>z", function()
  --   require("zen-mode").toggle({
  --     window = {
  --       width = 0.85, -- width will be 85% of the editor width
  --     },
  --   })
  -- end, { silent = true, nowait = true, desc = "Zoom Window" })
end
