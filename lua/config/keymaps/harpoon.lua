return function(hydra)
  hydra({
    name = "Harpoon",
    hint = [[
            Harpoon
--------------------
 _a_:             add
 _t_:          toggle
 _l_:            next
 _h_:            prev
 _<Esc>_ | _q_:    exit
    ]],
    mode = { 'n', 'x' },
    config = {
      timeout = false,
      invoke_on_body = true,
      hint = {
        type = "window",
        position = "middle-right",
        border = "rounded",
      }
    },
    body = '<leader>h',
    heads = {
      { 'a',     require('harpoon.mark').add_file,        { desc = "add", exit = true, nowait = true } },
      { 't',     require('harpoon.ui').toggle_quick_menu, { desc = "ui", exit = true, nowait = true } },
      { 'l',     require('harpoon.ui').nav_next,          { desc = "next" } },
      { 'h',     require('harpoon.ui').nav_prev,          { desc = "prev" } },
      { 'q',     nil,                                     { exit = true, nowait = true, desc = 'exit' } },
      { '<Esc>', nil,                                     { exit = true, nowait = true, desc = 'exit' } },
    },
  })
end
