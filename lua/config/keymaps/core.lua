local Util = require("util")

return function(map)
  map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Move curor down" })
  map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Move curor up" })

  map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
  map("n", "<leader>q", "<cmd>q<cr>", { desc = "Close Window" })
  map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New File" })
  map("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force Write" })
  map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force Quit" })

  map("n", "<space>-", "<cmd>:split<cr>", { desc = "Split Window (horizontal)" })
  map("n", "<space>_", "<cmd>:vsplit<cr>", { desc = "Split Window (vertical)" })

  -- better indenting
  map("v", "<", "<gv", { desc = "Unident Line" })
  map("v", ">", ">gv", { desc = "Ident Line" })
  map("v", "<S-Tab>", "<gv", { desc = "Unident Line" })
  map("v", "<Tab>", ">gv", { desc = "Ident Line" })
  map("v", "q", "gq", { desc = "format text" })

  map("n", "<C-j>", "<C-w>j", { desc = "Move to above split" })
  map("n", "<C-k>", "<C-w>k", { desc = "Move to below split" })
  map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
  map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
  map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
  map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

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

  map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
  map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
  map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
  map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
  map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

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

  map("n", "mc", require("fold-cycle").close_all, { desc = "Close" })
  map("n", "mt", require("fold-cycle").toggle_all, { desc = "toggle fold" })
end
