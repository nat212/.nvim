local jdt_root
local jdt_config
local workspace_root
local jdt_version = "1.6.400.v20210924-0641"
if require("natashz.util").is_windows then
	jdt_root = "C:/tools/jdt-language-server"
	jdt_config = "config_win"
	workspace_root = vim.loop.os_homedir() .. "/.jdt"
else
	-- TODO: Add unix path
	jdt_config = "config_linux"
end

local function get_workspace_dir()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	return workspace_root .. "/" .. project_name
end

local config = {
	cmd = {
		"java",
		"-javaagent:" .. jdt_root .. "/lombok.jar",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		jdt_root .. "/plugins/org.eclipse.equinox.launcher_" .. jdt_version .. ".jar",
		"-configuration",
		jdt_root .. "/" .. jdt_config,
		"-data",
		get_workspace_dir(),
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
}
require("jdtls").start_or_attach(config)
