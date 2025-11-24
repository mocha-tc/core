local fusion = require("../../../roblox_packages/Fusion")
local types = require("../types")

local button_component = require("../components/button")

local story = {
	fusion = fusion,

	story = function(properties: types.story_props)
		local scope = fusion:scoped({
			button = button_component,
		})

		print(scope)

		local inst = scope:button({
			Name = "test",
			Parent = properties.target,

			Size = UDim2.fromOffset(100, 100),
		})

		return function()
			inst:Destroy()
		end
	end,
} :: types.story

return story
