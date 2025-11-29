-- name: plugin_global
-- description: quick access to plugin from anywhere
-- class: export
-- author(s): Primiti_ve

local plugin_global = nil

function get()
	return plugin_global
end

function set(plugin: any)
	plugin_global = plugin
end

return {
	get = get,
	set = set,
}
