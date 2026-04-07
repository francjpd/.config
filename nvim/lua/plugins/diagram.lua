return {
  "3rd/diagram.nvim",
  dependencies = {
    "3rd/image.nvim",
  },
  config = function()
    require("image").setup()
  end,
  opts = {
    -- Disable automatic rendering for manual-only workflow
    events = {
      render_buffer = {}, -- Empty = no automatic rendering
      clear_buffer = { "BufLeave" },
    },
    renderer_options = {
      mermaid = {
        theme = "dark",
        scale = 2,
      },
    },
  },
  keys = {
    {
      "<leader>K", -- or any key you prefer
      function()
        require("diagram").show_diagram_hover()
      end,
      mode = "n",
      ft = { "markdown", "norg" }, -- Only in these filetypes
      desc = "Show diagram in new tab",
    },
  },
}
