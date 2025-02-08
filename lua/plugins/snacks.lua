return {
  "folke/snacks.nvim",
  opts = {
    indent = {
      enabled = true,
      only_scope = false,
    },
    scope = { enabled = false },
  },
  --stylua: ignore
  keys = {
    { "<leader>sf", function() Snacks.picker.files() end, desc = "Find Files" },
  }
,
}
