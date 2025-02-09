return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    keys = {
      { "<c-k>", "<cmd>Lspsaga peek_type_definition<CR>", "Type [D]efinition" },
      { "<leader>rn", "<cmd>Lspsaga rename<CR>", "[R]e[n]ame" },
      { "<leader>ca", "<cmd>Lspsaga code_action<CR>", "[C]ode [A]ction", { "n", "x" } },
      { "K", "<cmd>Lspsaga hover_doc<CR>", "Hover Documentation" },
      { "gh", "<cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
      { "gp", "<cmd>Lspsaga peek_definition<CR>", "Peek Definition" },
      { "go", "<cmd>Lspsaga outline<CR>", "Goto outline" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>o", group = "Orgmode", icon = { icon = "", color = "orange" } },
        { "<leader>cl", group = "Chainsaw", icon = { icon = "🪚", color = "cyan" } },
      },
    },
  },
}
