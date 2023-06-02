vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.number = true
vim.opt.helplang = 'ja', 'en'
vim.opt.clipboard:append{'unnamedplus'}
vim.opt.termguicolors = true
vim.opt.signcolumn = 'no'
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.ignorecase = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 3
vim.opt.cursorline = true

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.api.nvim_create_augroup( 'fcitx', {} )
vim.api.nvim_create_autocmd({'insertleave', 'cmdlineleave'}, {
	group = 'fcitx',
	callback = function() os.execute('fcitx5-remote -c') end
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
	"sainnhe/gruvbox-material",
	{ "vim-jp/vimdoc-ja", ft = "help" },
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{ "hrsh7th/nvim-cmp", event = "InsertEnter, CmdlineEnter" },
	{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
	{ "hrsh7th/cmp-cmdline", event = "InsertEnter" },
	{ "hrsh7th/cmp-path", event = "InsertEnter" },
	{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
	{ "hrsh7th/cmp-vsnip", event = "InsertEnter" },
	{ "hrsh7th/vim-vsnip", event = "InsertEnter" },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append "eol:↴"
			require("indent_blankline").setup({
				show_end_of_line = true,
			})
		end,
	},
	{ "folke/neodev.nvim", opts = {} },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function ()
			require('lualine').setup {
				options = {
					icons_enabled = true,
			    	theme = 'auto',
			    	component_separators = { left = '', right = ''},
			    	section_separators = { left = '', right = ''},
			    	disabled_filetypes = {
			      		statusline = {},
			      		winbar = {},
			    	},
			    	ignore_focus = {},
			    	always_divide_middle = true,
			    	globalstatus = false,
			    	refresh = {
			    		statusline = 1000,
			      		tabline = 1000,
			      		winbar = 1000,
			    	}
			  },
			  sections = {
			    	lualine_a = {'mode'},
			    	lualine_b = {
						'branch',
						{
							'diff',
							symbol = {added = '+', modified = '~', removed = '-'}
						},
						{
							'diagnostics',
							symbol = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
						},
					},
			    	lualine_c = {'filename'},
			    	lualine_x = {'encoding', 'fileformat', 'filetype'},
			    	lualine_y = {'progress'},
			    	lualine_z = {'location'}
			  },
			  inactive_sections = {
			    	lualine_a = {},
			    	lualine_b = {},
			    	lualine_c = {'filename'},
			    	lualine_x = {'location'},
			    	lualine_y = {},
			    	lualine_z = {}
			  },
			  tabline = {},
			  winbar = {},
			  inactive_winbar = {},
			  extensions = {}
			}
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function ()
			require("gitsigns").setup()
		end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true})
		end,
	},
}
require("lazy").setup(plugins)
require("neoconf").setup()
require("mason").setup()
require("mason-lspconfig").setup_handlers({
	function(server)
		local opt = {
			capabilities = require("cmp_nvim_lsp").default_capabilities()
		}
		require("lspconfig")[server].setup(opt)
	end
})

local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	experimental = {
		ghost_text = true,
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'nvim_lsp_signature_help' },
	}, {
		{ name = 'buffer' },
	})
})

cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

vim.cmd.colorscheme('gruvbox-material')
