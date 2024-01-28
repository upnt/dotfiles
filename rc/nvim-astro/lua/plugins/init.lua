return {
  {
    "tzachar/cmp-tabnine",
    requires = "hrsh7th/nvim-cmp",
    after = "nvim-cmp",
    run = "./install.sh",
    config = function()
      require("cmp_tabnine.config").setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        ignored_file_types = {
          -- lua = true
        },
        show_prediction_strength = false,
      }
      require("core.utils").add_cmp_source { name = "cmp_tabnine", priority = 1000, max_item_count = 7 }
    end,
  },
  {
    "refamadriz/friendly-snippets",
    event = { nil },
  },
}
