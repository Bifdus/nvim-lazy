return {
  "saghen/blink.cmp",
  opts = {
    -- enabled = function()
    --   return not vim.tbl_contains({ "org", "markdown" }, vim.bo.filetype)
    --     and vim.bo.buftype ~= "prompt"
    --     and vim.b.completion ~= false
    -- end,
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-y>"] = { "select_and_accept" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
    -- completion = {
    --   trigger = {
    --     show_on_trigger_character = true,
    --     show_on_insert_on_trigger_character = true,
    --     show_on_x_blocked_trigger_characters = { "'", '"', "(", "{", "<" },
    --   },
    -- },
  },
}
