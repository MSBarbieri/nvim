local M = {}

local defaults = {
  opt = {
    autowrite = true, -- Enable auto write
    clipboard = "unnamedplus", -- Sync with system clipboard
    completeopt = "menu,menuone,noselect",
    conceallevel = 3, -- Hide * markup for bold and italic
    confirm = true, -- Confirm to save changes before exiting modified buffer
    cursorline = true, -- Enable highlighting of the current line
    expandtab = true, -- Use spaces instead of tabs
    formatoptions = "jcroqlnt", -- tcqj
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg, --vimgrep",
    ignorecase = true, -- Ignore case
    inccommand = "nosplit", -- preview incremental substitute
    list = false, -- Show some invisible characters (tabs...
    mouse = "a", -- Enable mouse mode
    number = true, -- Print line number
    pumblend = 0, -- Popup blend
    pumheight = 0, -- Maximum number of entries in a popup
    relativenumber = true, -- Relative line numbers
    scrolloff = 4, -- Lines of context
    sessionoptions = { "buffers", "curdir", "tabpages", "winsize" },
    shiftround = true, -- Round indent
    shiftwidth = 2, -- Size of an indent
    shortmess = vim.opt.shortmess:append({ W = true, I = true, c = true, C = true }),
    showmode = false, -- Dont show mode since we have a statusline
    sidescrolloff = 8, -- Columns of context
    signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
    smartcase = true, -- Don't ignore case with capitals
    smartindent = true, -- Insert indents automatically
    spelllang = { "en" },
    splitbelow = true, -- Put new windows below current
    splitright = true, -- Put new windows right of current
    timeoutlen = 0,
    undofile = true,
    undolevels = 10000,
    updatetime = 200, -- Save swap file and trigger CursorHold
    wildmode = "longest:full,full", -- Command-line completion mode
    winminwidth = 5, -- Minimum window width
    wrap = false, -- Disable line wrap
    splitkeep = "screen",
  },
  g = {
    markdown_recommended_style = 1,
  },
}

function M.setup(opts)
  M.g = vim.tbl_deep_extend("force", defaults.g, opts.g or {})
  M.opt = vim.tbl_deep_extend("force", defaults.opt, opts.opt or {})

  for k, v in pairs(M.g) do
    vim.g[k] = v
  end
  for k, v in pairs(M.opt) do
    vim.opt[k] = v
  end
end

return M
