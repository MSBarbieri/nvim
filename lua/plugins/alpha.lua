return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                              WW              ",
        "                               WXNW         W0ol0W WWW        ",
        "                         WNW XxcoKWWW     WXx,..;ddccxX       ",
        "                         0oO0c.'ldldkxxddol;........lX        ",
        "                         k,::'.....''..............'k         ",
        "                  WW   W0c..........................l0kON     ",
        "                 NkkOxoc,............................'.;OW    ",
        "            WWWKx:'.....................................lN    ",
        "           Xxxo,........................................cX    ",
        "           O;'..........................................:K    ",
        "         NNO,...........................................;O    ",
        "         0oo;...........................................;0    ",
        "         Nd,...........................,ldl;............oN    ",
        "        WKd;..........................:cc:codl,.......,dX     ",
        "       Xo,..........................;:lolokKKKd'...:dOXW      ",
        "      Nd;'.........................'cookKXXKkO0koclOXXW       ",
        "      NOc...........................:OXXXXXOxOXXXXK00kK       ",
        "       O;..........................ckKXXXXXKKXXXXXXXKOK       ",
        "       NO:........................,dKXXXXXXXXXXXXXXXKkKWNXKN  ",
        "        Wd........................,oOKXXXXXXXXXXXXK0xdOXXXXW  ",
        "   WKKXKx;.................''.......:dKXXXXXXXXXOOkxdxXW      ",
        "   W0l;,...................:oooc:::ldOKXXXXXXXXX0O00O0N       ",
        "   Nk;.....................;xKXKOOxOXXXXXXXXXXXXXXXXKOX       ",
        "  WO:.......................,cddddxkOOO0XXXXXXXXXXXXX00N      ",
        "  Wk;''..........................;d0XK0000KXXXXKKKK0K0KW      ",
        "  W0O00Oxc'......................c0XXXXXXXXX0k0XXXXNNW        ",
        "         Nk;..................':ld0XXXXXXXXKOKW               ",
        "          WXkl'',,;;,,;;:;cloodkOOOOO0000K0O0W                ",
        "             KolxO0OkkO0OOKKKKKKKKKK00OOOOOO0KKKKKN           ",
        "             Nd,cOKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0kxOXW         ",
        "             0;..ckO0KKKKKKKKKKKKKKKKKKKKKKKKK0kkOOKW         ",
        "            Xl....';:cldxkO000O000KKKKKKKKKKK0OkOO0N          ",
        "          W0c'..........',;:lodxkkO0KKKKKKKK0Oxk0XW           ",
        "        W0l,..................';codkk0KKKKK0kxOXW             ",
      }
      dashboard.section.buttons.val = {
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 0
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
