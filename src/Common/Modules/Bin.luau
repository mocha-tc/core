-- name: Bin
-- description: simple memory management
-- class: utility
-- author(s): Red-Blox, Primiti_ve

export type BinItem = Instance | RBXScriptConnection | () -> ...any
export type Bin = {
	_Bin: { BinItem },

	Add: (Item: BinItem) -> (),
	Empty: () -> (),
}

return function(CustomFunctions: { [string]: (any) -> () }): Bin
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
				-- get type of Item
				local Type = typeof(Item)

				if Type == "Instance" then
					-- destroy Item
					Item:Destroy()
				elseif Type == "RBXScriptConnection" then
					-- disconnect Item
					Item:Disconnect()
				elseif Type == "function" then
					-- run Item
					task.spawn(Item)
				else
					-- check if CustomFunctions[Type] exists
					if CustomFunctions[Type] and typeof(CustomFunctions[Type]) == "function" then
						-- run CustomFunctions[Type]
						CustomFunctions[Type](Item)
					end
				end
			end

			-- clear Bin
			table.clear(Bin)
		end,

		-- internal usage
		_Bin = Bin,
	} :: Bin
end
