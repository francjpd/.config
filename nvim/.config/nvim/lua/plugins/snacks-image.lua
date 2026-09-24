--- Inline image rendering for markdown (and other supported filetypes).
---
--- Uses the built-in snacks.nvim `image` module. It renders `png`, `jpg`,
--- `gif`, `webp`, `pdf`, `svg` (converted via ImageMagick), and more,
--- directly inside the buffer.
---
--- IMPORTANT: this needs a terminal that implements the Kitty Graphics
--- Protocol. Ghostty (installed) works; your current default terminal,
--- foot, only supports sixel and will NOT render these inline. Run nvim
--- from Ghostty for images to show up. Check `:checkhealth snacks`.
return {
  "folke/snacks.nvim",
  opts = {
    image = {
      enabled = true,
      -- `doc.inline` (default) draws the image inside the buffer on
      -- terminals with unicode placeholder support (ghostty/kitty).
      -- `doc.float` is the fallback for other supported terminals.
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_width = 80,
        max_height = 40,
      },
    },
  },
}
