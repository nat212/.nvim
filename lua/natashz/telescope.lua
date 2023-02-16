local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

-- Telescope setup
telescope.setup({
	defaults = { mappings = { n = { ["q"] = actions.close } } },
	pickers = {
		git_commits = { theme = "dropdown" },
		buffers = { theme = "dropdown" },
		git_branches = { theme = "dropdown" },
	},
	extensions = {
		file_browser = { hijack_netrw = true, theme = "dropdown" },
		lsp_handlers = {
			code_action = {
				telescope = require("telescope.themes").get_dropdown({}),
			},
		},
	},
})

-- Project files
local project_files = function()
	vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		require("telescope.builtin").git_files({ show_untracked = true })
	else
		require("telescope.builtin").find_files()
	end
end

local function load_telescope_plugin(plugin)
	pcall(telescope.load_extension, plugin)
end

-- Extensions
load_telescope_plugin("file_browser")
load_telescope_plugin("fzf")
load_telescope_plugin("command_center")
load_telescope_plugin("todo-comments")
load_telescope_plugin("flutter")
load_telescope_plugin("notify")
load_telescope_plugin("projects")

-- Keybinds

-- Git files
vim.keymap.set("n", ";f", project_files)
-- Git branches
vim.keymap.set("n", ";gb", function()
	builtin.git_branches()
end)
-- Live grep
vim.keymap.set("n", ";r", function()
	builtin.live_grep()
end)
-- Buffers
vim.keymap.set("n", "\\\\", function()
	builtin.buffers()
end)
-- Help tags
vim.keymap.set("n", ";t", function()
	builtin.help_tags()
end)
-- Resume
vim.keymap.set("n", ";;", function()
	builtin.resume()
end)
-- Diagnostics
vim.keymap.set("n", ";e", function()
	builtin.diagnostics()
end)
-- File browser
vim.keymap.set("n", ";b", function()
	telescope.extensions.file_browser.file_browser({
		-- path = '%:p:h',
		-- cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end, { noremap = true })
-- Planets
vim.keymap.set("n", ";p", require("telescope").extensions.projects.projects)
-- Colour schemes
vim.keymap.set("n", ";gc", builtin.git_commits)
-- Symbols
vim.keymap.set("n", ";o", builtin.treesitter)
-- TODOs
vim.keymap.set("n", ";t", require("telescope").extensions["todo-comments"].todo)
-- neoclip
vim.keymap.set("n", ";y", require("telescope").extensions.neoclip.neoclip)
-- Command center
vim.keymap.set("n", ";c", require("telescope").extensions.command_center.command_center)
-- Flutter tools
vim.keymap.set("n", ";df", require("telescope").extensions.flutter.commands)
-- Notify
vim.keymap.set("n", ";n", require("telescope").extensions.notify.notify)

-- Load command center
-- require("natashz.command")
