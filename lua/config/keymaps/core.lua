local Util = require("util")
local splits = require('smart-splits')
local cmd = require('hydra.keymap-util').cmd
local pcmd = require('hydra.keymap-util').pcmd
return function(hydra, map)
  local buffer_hydra = hydra({
    name = 'buffer',
    hint = [[
               Buffer
----------------------
 _h_:              prev
 _l_:              next
 _d_:            delete
 _t_:         telescope
----------------------
 _<Esc>_ | _q_:      exit
    ]],
    config = {
      invoke_on_body = true,
      hint = {
        type = "window",
        position = "bottom-right",
        border = "rounded",
      },
    },
    heads = {
      { 'h',     function() vim.cmd('bprevious') end,         { on_key = false } },
      { 'l',     function() vim.cmd('bnext') end,             { desc = 'choose', on_key = false } },

      { 'd',     function() vim.cmd('bdelete') end,           { desc = 'close' } },
      { 't',     function() vim.cmd('Telescope buffers') end, { desc = "telescope", exit = true } },

      { 'q',     nil,                                         { exit = true } },
      { '<Esc>', nil,                                         { exit = true } }
    }
  })

  local function choose_buffer()
    if #vim.fn.getbufinfo({ buflisted = true }) > 1 then
      buffer_hydra:activate()
    end
  end

  hydra({
    name = "Windows",
    hint = [[
 ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
 ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
 ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally
 _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<C-h>_ _<C-l>_   _v_: vertically
 ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<C-j>_   ^   _q_: close
 focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
 ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
]],
    config = {
      invoke_on_body = true,
      hint = {
        type = "window",
        position = "bottom-right",
        border = "rounded",
      },
    },
    mode = { 'n', 'x' },
    body = '<C-w>',
    heads = {
      { 'h',     '<C-w>h' },
      { 'j',     '<C-w>j' },
      { 'k',     pcmd('wincmd k', 'E11', 'close') },
      { 'l',     '<C-w>l' },

      { 'H',     cmd 'WinShift left' },
      { 'J',     cmd 'WinShift down' },
      { 'K',     cmd 'WinShift up' },
      { 'L',     cmd 'WinShift right' },

      { '<C-h>', function() splits.resize_left(2) end },
      { '<C-j>', function() splits.resize_down(2) end },
      { '<C-k>', function() splits.resize_up(2) end },
      { '<C-l>', function() splits.resize_right(2) end },
      { '=',     '<C-w>=',                             { desc = 'equalize' } },

      { 's',     pcmd('split', 'E36') },
      { '<C-s>', pcmd('split', 'E36'),                 { desc = false } },
      { 'v',     pcmd('vsplit', 'E36') },
      { '<C-v>', pcmd('vsplit', 'E36'),                { desc = false } },

      { 'z',     cmd 'WindowsMaximaze',                { exit = true, desc = 'maximize' } },
      { '<C-z>', cmd 'WindowsMaximaze',                { exit = true, desc = false } },

      { 'o',     '<C-w>o',                             { exit = true, desc = 'remain only' } },
      { '<C-o>', '<C-w>o',                             { exit = true, desc = false } },

      { 'b',     choose_buffer,                        { exit = true, desc = 'choose buffer' } },

      { 'd',     pcmd('close', 'E444'),                { desc = 'close window' } },
      { 'q',     nil,                                  { exit = true, desc = 'exit' } },
      { '<Esc>', nil,                                  { exit = true, desc = 'exit' } },
    }
  })

  map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move curor down" })
  map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move curor up" })

  map("n", "<leader>b", choose_buffer, { desc = "Choose buffer" })

  map("n", "<C-j>", "<C-w>j", { desc = "Move to above split" })
  map("n", "<C-k>", "<C-w>k", { desc = "Move to below split" })
  map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
  map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

  map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
  map("n", "<leader>q", "<cmd>q<cr>", { desc = "Close Window" })
  map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File" })
  map("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force Write" })
  map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force Quit" })

  -- better indenting
  map("v", "<", "<gv", { desc = "Unident Line" })
  map("v", ">", ">gv", { desc = "Ident Line" })
  map("v", "<S-Tab>", "<gv", { desc = "Unident Line" })
  map("v", "<Tab>", ">gv", { desc = "Ident Line" })
  map("v", "q", "gq", { desc = "format text" })

  map("n", "<leader>;", "<cmd>Alpha<cr>", { desc = "Alpha" })

  if Util.has("bufferline.nvim") then
    map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
    map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
    map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
    map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  else
    map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
    map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
    map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
    map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
  end

  -- Clear search with <esc>
  map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
  -- Serach word under cursor
  map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

  -- Coment
  map("n", "<leader>/", function()
    require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
  end, { desc = "Toggle comment line" })
  map(
    "v",
    "<leader>/",
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    { desc = "Toggle comment line for selection" }
  )

  map({ "n", "x" }, "<leader>m", require("fold-cycle").toggle_all, { desc = "toggle fold" })
end
