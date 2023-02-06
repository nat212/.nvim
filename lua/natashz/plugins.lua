local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- ~ Aesthetics ~
	use({ "dracula/vim", as = "dracula", config = "vim.cmd[[colo dracula]]" })
	use({ "gruvbox-community/gruvbox" })
	use({ "kyazdani42/nvim-web-devicons" })
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("natashz.statusline")
		end,
		requires = { "kyazdani42/nvim-web-devicons" },
	})
	use({
		"stevearc/dressing.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("dressing").setup({
				select = {
					enabled = true,
					telescope = require("telescope.themes").get_cursor(),
					builtin = {
						relative = "cursor",
						start_in_insert = true,
						windblend = 40,
					},
				},
			})
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		config = function()
			require("natashz.tabs")
		end,
	})
	use({
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	})

	-- Git
	use({
		"tpope/vim-fugitive",
		"junegunn/gv.vim",
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
			requires = { "nvim-lua/plenary.nvim" },
		},
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"FeiyouG/command_center.nvim",
			"LinArcX/telescope-changes.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		config = function()
			require("natashz.telescope")
		end,
	})

	use({
		"AckslD/nvim-neoclip.lua",
		requires = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("neoclip").setup()
		end,
	})

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	})

	-- Movement/Utilities
	use({ "mg979/vim-visual-multi", branch = "master" })
	use({ "tpope/vim-surround" })
	use({ "tpope/vim-commentary" })
	-- use({
	-- 	"ThePrimeagen/harpoon",
	-- 	config = function()
	-- 		require("natashz.harpoon")
	-- 	end,
	-- })
	use({
		"voldikss/vim-floaterm",
		config = function()
			require("natashz.floaterm")
		end,
	})

	-- LSP Stuff
	use("mfussenegger/nvim-jdtls")
	use({
		"akinsho/flutter-tools.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("natashz.flutter").setup()
		end,
	})
	use({
		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup({})
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("mason-lspconfig").setup({})
			end,
		},
		"neovim/nvim-lspconfig",
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"neovim/nvim-lspconfig",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("natashz.lsp")
		end,
	})
	use("sbdchd/neoformat")
	use("rafamadriz/friendly-snippets")
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup({
				highlight_hovered_item = true,
				show_guides = true,
				auto_close = true,
			})
		end,
	})
	use({
		"glepnir/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				code_action_lightbulb = { enable = false },
			})
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = {
					enable = true,
					disable = { "yaml" },
				},
				auto_install = true,
			})
		end,
	})

	-- DAP
	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup()
		end,
	})

	-- Other language stuff
	use({ "rust-lang/rust.vim" })
	use({ "editorconfig/editorconfig-vim" })
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && yarn install",
		ft = { "markdown" },
	})
	use({
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({
				library = {
					plugins = { "nvim-dap-ui" },
					types = true,
				},
			})
		end,
	})

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
		ft = { "html", "typescriptreact", "javascriptreact", "vue", "svelte" },
	})

	-- Wakatime
	use("wakatime/vim-wakatime")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
