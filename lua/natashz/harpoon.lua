require'harpoon.init'.setup({
	enter_on_sendcmd = true,
})

local keymap = require'natashz.keymap'
local harpoonTerm = require'harpoon.term'
local harpoonCmdUi = require'harpoon.cmd-ui'

local function goto_terminal(num)
	harpoonTerm.gotoTerminal(num)
end

local function cmd_ui()
	harpoonCmdUi.toggle_quick_menu()
end

keymap.nnoremap('<leader>ht1', function ()
	goto_terminal(1)
end)

keymap.nnoremap('<leader>ht2', function ()
	goto_terminal(2)
end)

keymap.nnoremap('<leader>hc', cmd_ui)
