return {
  {
    {
      "mikavilpas/yazi.nvim",
      cmd = "Yazi",
      -- event = 'VeryLazy',
      keys = {
        {
          "\\",
          "<cmd>Yazi<cr>",
          desc = "Open yazi at the current file",
        },
        {
          -- Open in the current working directory
          "|",
          "<cmd>Yazi cwd<cr>",
          desc = "Open the file manager in nvim's working directory",
        },
        {
          -- NOTE: this requires a version of yazi that includes
          -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
          "<leader>cr",
          "<cmd>Yazi toggle<cr>",
          desc = "Resume the last yazi session",
        },
      },
      ---@type YaziConfig
      opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = true,
        keymaps = {
          show_help = "<f1>",
        },
      },
    },
  },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      -- Add cursors above/below the main cursor.
      vim.keymap.set({ "n", "v" }, "<M-Up>", function()
        mc.addCursor("gk")
      end, { noremap = true, silent = true })
      vim.keymap.set({ "n", "v" }, "<M-Down>", function()
        mc.addCursor("gj")
      end)

      -- Rotate the main cursor.
      vim.keymap.set({ "n", "v" }, "<M-left>", mc.nextCursor)
      vim.keymap.set({ "n", "v" }, "<M-right>", mc.prevCursor)

      -- Add and remove cursors with alt + left click.
      vim.keymap.set("n", "<M-leftmouse>", mc.handleMouse)

      -- Add a cursor and jump to the next word under cursor.
      -- TODO: Find a good replacement
      -- vim.keymap.set({ 'n', 'v' }, '<c-a>', function()
      --   mc.addCursor '*'
      -- end)

      -- Jump to the next word under cursor but do not add a cursor.
      vim.keymap.set({ "n", "v" }, "<c-n>", function()
        mc.skipCursor("*")
      end)

      -- Delete the main cursor.
      vim.keymap.set({ "n", "v" }, "<leader>z", mc.deleteCursor)

      vim.keymap.set({ "n", "v" }, "<c-q>", function()
        if mc.cursorsEnabled() then
          -- Stop other cursors from moving.
          -- This allows you to reposition the main cursor.
          mc.disableCursors()
        else
          mc.addCursor()
        end
      end)

      -- Align cursor columns.
      vim.keymap.set("n", "<leader>a", mc.alignCursors)

      -- Split visual selections by regex.
      vim.keymap.set("v", "S", mc.splitCursors)

      -- Append/insert for each line of visual selections.
      vim.keymap.set("v", "I", mc.insertVisual)
      vim.keymap.set("v", "A", mc.appendVisual)
      -- match new cursors within visual selections by regex.
      vim.keymap.set("v", "M", mc.matchCursors)

      -- Rotate visual selection contents.
      vim.keymap.set("v", "<leader>t", function()
        mc.transposeCursors(1)
      end)
      vim.keymap.set("v", "<leader>T", function()
        mc.transposeCursors(-1)
      end)

      -- Customize how cursors look.
      vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
      vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    end,
  },

  -----------------------------------------------------------------------------
  -- Note taking and todo list
  {
    "nvim-orgmode/orgmode",
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        calendar = { round_min_with_hours = true, min_big_step = 15, min_small_step = 1 },
        org_log_repeat = "time",
        org_id_method = "ts",
        org_agenda_span = "week",
        org_agenda_files = "~/orgfiles/**/*",
        org_archive_location = "~/orgfiles/archive.org::/From %s",
        org_default_notes_file = "~/orgfiles/refile.org",
        org_refile_target_files = "~/orgfiles/archive.org",
        win_split_mode = function(name)
          -- Make sure it's not a scratch buffer by passing false as 2nd argument
          local bufnr = vim.api.nvim_create_buf(false, false)
          --- Setting buffer name is required
          vim.api.nvim_buf_set_name(bufnr, name)

          local fill = 0.8
          local width = math.floor((vim.o.columns * fill))
          local height = math.floor((vim.o.lines * fill))
          local row = math.floor((((vim.o.lines - height) / 2) - 1))
          local col = math.floor(((vim.o.columns - width) / 2))

          vim.api.nvim_open_win(bufnr, true, {
            relative = "editor",
            width = width,
            height = height,
            row = row,
            col = col,
            style = "minimal",
            border = "rounded",
          })
        end,

        mappings = {
          global = {
            org_agenda = "<leader>oa",
            org_capture = "<leader>oc",
          },
        },
      })
    end,
  },

  {
    "folke/flash.nvim",
    -- stylua: ignore
    keys = {
      {
        '?',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
    },
  },

  -----------------------------------------------------------------------------
  --- Better Visual for help files
  {
    "OXY2DEV/helpview.nvim",
    -- lazy = false, -- Recommended
    ft = "help",

    -- In case you still want to lazy load
    -- ft = "help",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
