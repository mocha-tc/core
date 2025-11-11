-- name: Bin
-- description: simple memory management
-- class: utility
-- author(s): Red-Blox, Primiti_ve

export type BinItem = Instance | RBXScriptConnection | () -> ...any | thread
export type Bin = {
	Add: (Item: BinItem) -> (),
	Empty: () -> (),

	_Bin: { BinItem },
	_CustomFunctions: { [string]: (any) -> () },
}

return function(CustomFunctions: { [string]: (any) -> () }?): Bin
	CustomFunctions = CustomFunctions or {}

	local Bin: { BinItem } = {}

	return {
		Add = function(Item: BinItem)
			-- add BinItem to Bin
			table.insert(Bin, Item)

			return Item
		end,

		Empty = function()
			-- loop through all items in Bin
			for _, Item in pairs(Bin) do
				if typeof(Item) == "Instance" then
					-- destroy Item
					Item:Destroy()
				elseif typeof(Item) == "RBXScriptConnection" then
					-- disconnect Item
					Item:Disconnect()
				elseif typeof(Item) == "function" then
					-- run Item
					task.spawn(Item)
				elseif typeof(Item) == "thread" then
					-- cancel Item
					task.cancel(Item)
				else
					-- check if CustomFunctions[Type] exists
					if CustomFunctions[typeof(Item)] and typeof(CustomFunctions[typeof(Item)]) == "function" then
						-- run CustomFunctions[Type]
						CustomFunctions[typeof(Item)](Item)
					end
				end
			end

			-- clear Bin
			table.clear(Bin)
		end,

		-- internal usage
		_Bin = Bin,
		_CustomFunctions = CustomFunctions,
	} :: Bin
end
