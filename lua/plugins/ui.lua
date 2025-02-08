return {
  -----------------------------------------------------------------------------
  -- Adds scrollbar to buffer
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = { show = true, excluded_filetypes = { "NvimTree" } },
  },
}
