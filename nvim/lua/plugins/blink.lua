return {
  {
    "saghen/blink.cmp",
    optional = true,
    init = function()
      vim.g.blink_cmp_auto_show = true
    end,
    opts = function(_, opts)
      opts.completion = opts.completion or {}
      opts.completion.menu = opts.completion.menu or {}
      opts.completion.list = opts.completion.list or {}

      opts.completion.menu.auto_show = function(ctx)
        return vim.g.blink_cmp_auto_show ~= false
      end
      opts.completion.list.selection = opts.completion.list.selection or {}
      opts.completion.list.selection.preselect = false

      opts.keys = opts.keys or {}
      vim.list_extend(opts.keys, {
        {
          "<leader>uo",
          function()
            vim.g.blink_cmp_auto_show = not vim.g.blink_cmp_auto_show
            local msg = vim.g.blink_cmp_auto_show and "Auto-completion enabled" or "Auto-completion disabled"
            vim.notify(msg, vim.log.levels.INFO, { title = "Blink CMP" })
          end,
          desc = "Toggle auto-completion",
        },
      })
    end,
  },
}