return {
  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    ft = {
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "python",
    },
    config = true, -- run require("template-string").setup()
  },
}
