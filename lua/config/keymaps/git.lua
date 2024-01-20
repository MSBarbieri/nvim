local Util = require("util")
local gitsigns = require("gitsigns")
return function(hydra)
  hydra({
    name = "Git",
    hint = [[
 GIT
--------------------
 _b_:        branches
 _c_:  commits (file)
 _C_:  commits (repo)
 _t_:          status
 _h_ | _n_:        prev
 _l_ | _p_:        next
 _,_:           blame
 _<_:      full blame
 _d_:  toggle deleted
 _u_:      undo stage
 _s_:           stage
 _S_:    stage buffer
--------------------
 _<Enter>_:    Neogit
 _g_:         lazygit
 _<Esc>_ | _q_:    exit
    ]],
    mode = { 'n', 'x' },
    config = {
      invoke_on_body = true,
      color = 'red',
      hint = {
        type = "window",
        position = "bottom-right",
        border = "rounded",
      },
      on_key = function() vim.wait(50) end,
      on_enter = function()
        vim.cmd 'mkview'
        vim.cmd 'silent! %foldopen!'
        gitsigns.toggle_linehl(true)
        gitsigns.toggle_deleted(true)
      end,
      on_exit = function()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd 'loadview'
        vim.api.nvim_win_set_cursor(0, cursor_pos)
        vim.cmd 'normal zv'
        gitsigns.toggle_linehl(false)
        gitsigns.toggle_deleted(false)
      end,
    },
    body = '<leader>g',
    heads = {
      { 'b', function()
        require("telescope.builtin").git_branches({ use_file_path = true })
      end, { desc = "branches", nowait = true, exit = true }
      },
      { 'c', function()
        require("telescope.builtin").git_bcommits({ use_file_path = true })
      end, { desc = "commits (file)", nowait = true, exit = true }
      },
      { 'C', function()
        require("telescope.builtin").git_commits({ use_file_path = true })
      end, { desc = "commits (repo)", nowait = true, exit = true }
      },
      { 't', function()
        require("telescope.builtin").git_status({ use_file_path = true })
      end, { desc = "status", nowait = true, exit = true }
      },
      { 'h', gitsigns.prev_hunk,  { desc = "prev" } },
      { 'l', gitsigns.next_hunk,  { desc = "next" } },
      { 'p', gitsigns.prev_hunk,  { desc = "prev" } },
      { 'n', gitsigns.next_hunk,  { desc = "next" } },
      { ',', gitsigns.blame_line, { desc = "blame", exit = true } },
      { '<', function()
        gitsigns.blame_line({ full = true })
      end, { desc = "blame", exit = true } },
      { 'd', gitsigns.toggle_deleted,  { nowait = true, desc = 'toggle deleted' } },
      { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
      { 's',
        function()
          local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
          if mode == 'V' then                      -- visual-line mode
            local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)
            vim.api.nvim_feedkeys(esc, 'x', false) -- exit visual mode
            vim.cmd("'<,'>Gitsigns stage_hunk")
          else
            vim.cmd("Gitsigns stage_hunk")
          end
        end,
        { desc = 'stage hunk' } },
      { 'S',       gitsigns.stage_buffer, { desc = 'stage buffer' } },
      { 'q',       nil,                   { exit = true, nowait = true, desc = 'exit' } },
      { '<Esc>',   nil,                   { exit = true, nowait = true, desc = 'exit' } },
      { '<Enter>', '<Cmd>Neogit<CR>',     { exit = true, desc = 'Neogit' } },
      { 'g', function()
        local worktree = Util.file_worktrees()
        local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir) or ""
        Util.toggle_term_cmd("lazygit " .. flags)
      end, { nowait = true, exit_before = true, desc = 'Lazygit' } },
    }
  })
end
