return {
  "folke/snacks.nvim",

  --stylelua: ignore
  keys = {
    { "<leader>sf", function() Snacks.picker.files() end, desc = "Find Files" },
  }
}
