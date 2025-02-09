return {
  -----------------------------------------------------------------------------
  -- Quick log lines with smart variable identification, only python, lua and JS
  {
    "chrisgrieser/nvim-chainsaw",
    opts = {
      logStatements = {
        variableLog = {
          nvim_lua = 'vim.notify("%s %s", vim.inspect(%s))',
        },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Leetcode Problems
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    cmd = "Leet",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required by telescope
      "MunifTanjim/nui.nvim",

      -- optional
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- configuration goes here
      lang = "python3",
    },
  },
  {
    "roobert/f-string-toggle.nvim",
    config = function()
      require("f-string-toggle").setup({
        key_binding = "<leader>f",
        key_binding_desc = "Toggle f-string",
      })
    end,
  },

  -----------------------------------------------------------------------------
  -- VS Code like winbar
  {
    "utilyre/barbecue.nvim",
    dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<Leader>tB",
        function()
          local off = vim.b["barbecue_entries"] == nil
          require("barbecue.ui").toggle(off and true or nil)
        end,
        desc = "Breadcrumbs toggle",
      },
    },
    opts = {
      enable = true,
      attach_navic = true,
      show_dirname = false,
      show_modified = true,
      -- kinds = kind_icons, -- Uncomment if you have kind_icons defined
      symbols = { separator = "" },
    },
    config = function(_, opts)
      require("barbecue").setup(opts)
    end,
  },
}
