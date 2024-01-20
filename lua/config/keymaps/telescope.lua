return function(hydra)
  hydra({
    name = "Telescope",
    hint = [[
          Telescope
--------------------
 _a_:           Files
 _e_:       Live Grep
 _m_:           Mason
 _$_:            Lazy
 _t_:           Todos
 _d_:     Diagnostics
--------------------
 _<Esc>_ | _q_:    exit
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
    mode = { 'n' },
    body = '<leader>t',
    heads = {
      { 'a',     "<cmd>Telescope find_files<cr>",  { desc = 'files' } },
      { 'e',     "<cmd>Telescope live_grep<cr>",   { desc = 'live_grep' } },
      { 'm',     "<cmd>Mason<cr>",                 { desc = 'Mason' } },
      { '$',     "<cmd>Lazy<cr>",                  { desc = 'Lazy' } },
      { 't',     "<cmd>TodoTelescope<cr>",         { desc = 'Find Todos' } },
      { 'd',     "<cmd>Telescope diagnostics<cr>", { desc = 'Find Diagnostics' } },
      { 'q',     nil,                              { desc = 'exit' } },
      { '<Esc>', nil,                              { desc = 'exit' } },
    }
  })
end
