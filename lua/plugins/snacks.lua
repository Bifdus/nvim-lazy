return {
  "folke/snacks.nvim",
  opts = {
    indent = {
      enabled = true,
      scope = {
        hl = "DraculaComment",
      },
    },
  },
  --stylua: ignore
  keys = {
    { "<leader>sf", function() Snacks.picker.files() end, desc = "Find Files" },
  }
,
}
