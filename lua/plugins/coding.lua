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
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
      open_fold_hl_timeout = 400,
      close_fold_kinds = { "imports", "comment" },
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winhighlight = "Normal:Folded",
          winblend = 0,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "[",
          jumpBot = "]",
        },
      },
      -- provider_selector = function(bufnr, filetype, buftype)
      --   return { "treesitter", "indent" }
      -- end,
    },
    config = function(_, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = (" 󰁂 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
        suffix = (" "):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      opts["fold_virt_text_handler"] = handler
      require("ufo").setup(opts)
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          -- vim.lsp.buf.hover()
          vim.cmd([[ Lspsaga hover_doc ]])
        end
      end)
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
    event = "InsertEnter",
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
  }
}
