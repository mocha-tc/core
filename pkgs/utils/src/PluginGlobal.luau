-- name: PluginGlobal
-- description: quick access to plugin from anywhere
-- class: export
-- author(s): Primiti_ve

local PluginGlobal = nil

function get()
	return PluginGlobal
end

function set(plugin: any)
	PluginGlobal = plugin
end

return {
	get = get,
	set = set,
}
