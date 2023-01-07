-- local template_cmd = "<CMD> lua RunTerminal('%s')<CR>"
-- require("which-key").register({
-- 	r = {
-- 		name = "Run",
-- 		r = {
-- 			string.format(
-- 				template_cmd,
-- 				"javac " .. vim.fn.expand("%") .. " && echo Running && java " .. vim.fn.expand("%:t:r")
-- 			),
-- 			"Run",
-- 		},
-- 		i = {
-- 			string.format(
-- 				template_cmd,
-- 				"javac " .. vim.fn.expand("%") .. " && echo Running && java " .. vim.fn.expand("%:t:r") .. " < in"
-- 			),
-- 			"Run with input",
-- 		},
-- 	},
-- })

local root_markers = { "gradlew", "mvnw", ".git", "pom.xml" }
local root_dir = require("jdtls.setup").find_root(root_markers)
local install_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
-- local executable = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
local workspace_folder = vim.fn.stdpath("data") .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
	cmd = {
		"java",

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
		vim.fn.glob(install_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

		"-configuration",
		install_dir .. "/config_linux",

		"-data",
		workspace_folder,
	},

	root_dir = root_dir,

	settings = {
		java = {},
	},

	init_options = {
		bundles = {},
	},
}

require("jdtls").start_or_attach(config)
