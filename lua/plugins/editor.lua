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
  -- Git UI
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Lazygit" },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    keys = {
      { "<Leader>gd", "<cmd>DiffviewFileHistory %<CR>", desc = "Diff File" },
      { "<Leader>gv", "<cmd>DiffviewOpen<CR>", desc = "Diff View" },
    },
    config = function()
      require("diffview").setup({
        keymaps = {
          view = {
            ["j"] = false,
            ["k"] = false,
            ["l"] = false,
            ["h"] = false,
          },
          file_panel = {
            ["j"] = false,
            ["k"] = false,
            ["l"] = false,
            ["h"] = false,
          },
          file_history_panel = {
            ["j"] = false,
            ["k"] = false,
            ["l"] = false,
            ["h"] = false,
          },
        },
      })
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPost",
    version = "*",
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "GitConflictDetected",
        callback = function()
          vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
        end,
      })

      require("git-conflict").setup({
        debug = true,
        default_mappings = true, -- disable buffer local mapping created by this plugin
        default_commands = true, -- disable commands created by this plugin
        disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
        list_opener = "copen", -- command or function to open the conflicts list
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = "DiffText",
          current = "DiffAdd",
        },
      })
    end,
    keys = {
      { "<Leader>gcb", "<cmd>GitConflictChooseBoth<CR>", desc = "choose both" },
      { "<Leader>gcn", "<cmd>GitConflictNextConflict<CR>", desc = "move to next conflict" },
      { "<Leader>gcc", "<cmd>GitConflictChooseOurs<CR>", desc = "choose current" },
      { "<Leader>gcp", "<cmd>GitConflictPrevConflict<CR>", desc = "move to prev conflict" },
      { "<Leader>gci", "<cmd>GitConflictChooseTheirs<CR>", desc = "choose incoming" },
    },
  },

  { "nvchad/volt", lazy = false },
  {
    "nvchad/minty",
    opts = { filetypes = { "css", "html", "typescript", "javascript", "tsx", "ts", "jsx" } },
    config = function(_, opts)
      require("minty").setup(opts)
    end,
  },
}
