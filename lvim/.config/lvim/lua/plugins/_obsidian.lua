local peek = require("peek")
local Terminal = require("toggleterm.terminal").Terminal
local Path = require("plenary.path")

return {
	"epwalsh/obsidian.nvim",
	-- dir = "/home/raghav/projects/obsidian.nvim/",
	-- dev = true,
	init = function()
		local makeNewNote = function()
			vim.ui.input({ prompt = "Enter title for new note: " }, function(title)
				vim.cmd("ObsidianNew " .. title)
			end)
		end

		local togglePreview = function()
			if peek.is_open() then
				peek.close()
			else
				peek.open()
			end
		end

		local openJournalThenRun = function(cmd)
			Terminal
				:new({
					cmd = vim.fn.expandcmd("source ~/.funcs.sh; journal open"),
					direction = "float",
					close_on_exit = true,
					on_open = function()
						vim.cmd("startinsert!")
					end,
					float_opts = {
						border = "curved",
						width = 20,
						height = 1,
					},
					on_exit = function(_, _, exit_code)
						print("exit " .. cmd)
						vim.fn.input({ prompt="hi  " })
						if exit_code == 0 and cmd ~= nil then
							vim.cmd(string.format("<CMD>%s<CR>", cmd))
						end

					end,
					on_close = function()
						print("close " .. cmd)
						vim.notify(cmd)
						-- 	if cmd ~= nil then
						-- 		vim.cmd(string.format("<CMD>%s<CR>", cmd))
						-- 	end
					end,
				})
			:open()
		end

		local closeJournal = function() end

		lvim.builtin.which_key.mappings["n"] = {
			name = "notes",
			n = { makeNewNote, "Create New Note" },
			b = { "<CMD>ObsidianBacklinks<CR>", "View Backlinks" },
			t = {
				function()
					openJournalThenRun("ObsidianToday")
				end,
				"Todays Note",
			},
			y = {
				function()
					openJournalThenRun("ObsidianYesterday")
				end,
				"Yesterdays Note",
			},
			o = { "<CMD>ObsidianQuickSwitch<CR>", "Open a note" },
			f = { "<CMD>ObsidianSearch<CR>", "Search inside notes" },
			i = { "<CMD>PasteImg<CR>", "Paste an image from clipboard" },
			p = { togglePreview, "Toggle Preview" },
			j = { openJournalThenRun, "Open Journal" },
			c = { closeJournal, "Close Journal" },
		}
		lvim.builtin.which_key.vmappings["n"] = {
			name = "notes",
			l = { "<CMD>'<,'>ObsidianLinkNew<CR>", "Link the selected text to a note" },
		}
	end,
	config = function()
		local notesDir = "~/notes/"
		require("obsidian").setup({
			dir = notesDir,
			completion = {
				nvim_cmp = true,
			},
			daily_notes = {
				folder = "journal/daily",
			},
			note_frontmatter_func = function(note)
				-- print(vim.inspect(note))
				local out = {
					id = note.id,
					aliases = note.aliases,
					tags = note.tags,
					created = os.date("%A, %d %B %Y at %I:%M %p"),
				}
				-- `note.metadata` contains any manually added fields in the frontmatter.
				-- So here we just make sure those fields are kept in the frontmatter.
				if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end
				return out
			end,
			note_id_func = function(title)
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end

				local cd = vim.fn.expand("%:~:h") .. "/"
				if string.find(cd, notesDir) then
					return string.gsub(cd, notesDir, "") .. suffix
				else
					return suffix
				end
			end,
		})
		vim.keymap.set("n", "gf", function()
			if require("obsidian").util.cursor_on_markdown_link() then
				return "<cmd>ObsidianFollowLink<CR>"
			else
				return "gf"
			end
			end, { noremap = false, expr = true })
	end,
}
