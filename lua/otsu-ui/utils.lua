local M = {}

M.list_themes = function()
	local default_themes = vim.fn.readdir(vim.fn.stdpath("data") .. "/lazy/based/lua/based/themes")
	local custom_themes = vim.uv.fs_stat(vim.fn.stdpath("config") .. "/lua/themes")

	if custom_themes and custom_themes.type == "directory" then
		local themes_tb = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/themes")
		for _, value in ipairs(themes_tb) do
			table.insert(default_themes, value)
		end
	end

	for index, theme in ipairs(default_themes) do
		default_themes[index] = theme:match("(.+)%..+")
	end

	return default_themes
end

M.replace_key_value = function(old, new)
	local otsurc = vim.uv.fs_realpath(vim.fn.stdpath("config") .. "/lua/otsuvim/config/otsurc.lua")
	local file = io.open(otsurc, "r")
	local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists
	local new_content = file:read("*all"):gsub(added_pattern, new)

	file = io.open(otsurc, "w")
	file:write(new_content)
	file:close()
end

M.set_cleanbuf_opts = function(ft)
	local opt = vim.opt_local

	opt.buflisted = false
	opt.modifiable = false
	opt.buftype = "nofile"
	opt.number = false
	opt.list = false
	opt.wrap = false
	opt.relativenumber = false
	opt.cursorline = false
	opt.colorcolumn = "0"
	opt.foldcolumn = "0"

	vim.opt_local.filetype = ft
	vim.g[ft .. "_displayed"] = true
end

return M
