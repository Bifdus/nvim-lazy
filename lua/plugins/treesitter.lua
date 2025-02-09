return {
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "nvim-treesitter/nvim-treesitter",
    -- opts = function(_, opts)
    --   vim.list_extend(opts.dependencies, {})
    -- end,

    -- https://github.com/nvim-treesitter/playground#query-linter
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" },
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      require("rainbow-delimiters.setup").setup()
    end,
  },
}
