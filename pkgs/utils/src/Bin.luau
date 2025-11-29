-- name: bin
-- description: simple memory management
-- class: utility
-- author(s): Red-Blox, Primiti_ve

export type bin_item = Instance | RBXScriptConnection | () -> ...any | thread
export type bin = {
	add: (item: bin_item) -> (),
	empty: () -> (),
}

function new(): bin
	local bin: { bin_item } = {}

	return {
		add = function(item: bin_item)
			-- add bin_item to bin
			table.insert(bin, item)

			return item
		end,

		empty = function()
			-- loop through all items in the bin
			for _, item in pairs(bin) do
				if typeof(item) == "Instance" then
					-- destroy item
					item:Destroy()
				elseif typeof(item) == "RBXScriptConnection" then
					-- disconnect item
					item:Disconnect()
				elseif typeof(item) == "function" then
					-- run item
					-- mainly used for any tasks that run when the bin is being emptied (e.g in-depth cleanup)
					task.spawn(item)
				elseif typeof(item) == "thread" then
					-- cancel item
					task.cancel(item)
				end
			end

			-- clear the bin
			table.clear(bin)
		end,
	} :: bin
end

return {
	new = new,
}
