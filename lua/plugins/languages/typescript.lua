return {
  -----------------------------------------------------------------------------
  -- Better typescript lsp
  {
    "pmizio/typescript-tools.nvim",
    ft = { "html", "css", "javascript", "typescript", "typescriptreact", "javascriptreact" },
    event = "LspAttach",
    -- dependencies = { "saghen/blink.cmp", lazy = false, priority = 1000 },
    opts = {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end

        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<leader>ttr", "<cmd>TSToolsRenameFile<CR>", opts)
        vim.keymap.set("n", "<leader>tti", "<cmd>TSToolsOrganizeImports<CR>", opts)
        vim.keymap.set("n", "<leader>tto", "<cmd>TSToolsSortImports<CR>", opts)
        vim.keymap.set("n", "<leader>tta", "<cmd>TSToolsAddMissingImports<CR>", opts)
      end,
    },
    config = function(_, opts)
      require("typescript-tools").setup(opts)
    end,
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
