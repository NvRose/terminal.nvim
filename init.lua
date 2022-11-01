local M = {}
local opts = {}

local set_behavior = function(behavior)
	local group = vim.api.nvim_create_augroup("terminal", { clear = true })
	if behavior.close_on_exit then
		vim.api.nvim_create_autocmd("TermClose", {
			callback = function()
				vim.schedule_wrap(vim.api.nvim_input("<cr>"))
			end,
			group = group,
		})
	end

	if behavior.auto_insert then
		vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
			callback = function()
				vim.cmd("start")
				vim.wo.rnu = false
				vim.wo.number = false
				vim.wo.cul = false
				vim.wo.list = false
				vim.wo.fdc = "1"
			end,
			pattern = "term://*",
			group = group,
		})

		vim.api.nvim_create_autocmd("BufLeave", {
			callback = function()
				vim.cmd("stopi")
			end,
			pattern = "term://*",
			group = group,
		})
	end
end

local set_keybinds = function(keybinds)
	for k, v in pairs(keybinds.inside) do
		vim.keymap.set("t", k, function()
			return v()
		end)
	end

	for k, v in pairs(keybinds.outside) do
		vim.keymap.set("n", k, function()
			return v()
		end)
	end
end

M.new = function()
	if opts.orientation == "horizontal" then
		vim.cmd("sp term://" .. opts.shell .. " | res " .. opts.resize)
	elseif opts.orientation == "vertical" then
		vim.cmd("vs term://" .. opts.shell .. " | vert res " .. opts.resize)
	end
end

M.close = function()
	vim.cmd("q")
end

local defaults = {
	shell = vim.o.shell,
	resize = 15,
	orientation = "horizontal",
	keybinds = {
		inside = {
			["<c-\\>"] = M.close,
		},
		outside = {
			["<c-\\>"] = M.new,
		},
	},
	behavior = {
		close_on_exit = true,
		auto_insert = true,
	},
}

M.setup = function(config)
	config = config and vim.tbl_deep_extend("force", defaults, config) or defaults
	set_behavior(config.behavior)
	set_keybinds(config.keybinds)
	opts = config
end

return M
