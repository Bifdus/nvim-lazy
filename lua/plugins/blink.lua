return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      -- ["<C-k>"] = {
      --   function(cmp)
      --     cmp.show()
      --   end,
      -- },
    },
    completion = {
      trigger = {
        show_on_trigger_character = true,
        show_on_insert_on_trigger_character = true,
        show_on_x_blocked_trigger_characters = { "'", '"', "(", "{", "<" },
      },
    },
  },
}
