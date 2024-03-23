return {
  {
    "numToStr/Comment.nvim",
    keys = {
      -- TODO: remove keys from here
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
  },
  {
    "jghauser/fold-cycle.nvim",
    config = function()
      require("fold-cycle").setup({
        open_if_max_closed = true,  -- closing a fully closed fold will open it
        close_if_max_opened = true, -- opening a fully open fold will close it
      })
    end,
  },

  {

    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        relculright = true,
        segments = {
          { text = { "%s" },                       click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc },           click = "v:lua.ScLa" },
          { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
          --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          --   {
          --     sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
          --     click = "v:lua.ScSa"
          --   },
          --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
          --   {
          --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          --     click = "v:lua.ScSa"
          --   },
        },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {},
  },
  {
    "RishabhRD/nvim-cheat.sh",
    dependencies = {
      "RishabhRD/popfix",
    },
  },
  {
    'windwp/nvim-autopairs',
    -- event = "InsertEnter",
    opts = {}
  },
  { 'ionide/Ionide-vim' },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-c>"
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = true,
        },
      })
    end,
  },
  {
    "David-Kunz/gen.nvim"
  }
}
