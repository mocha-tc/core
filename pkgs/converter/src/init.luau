-- name: converter
-- description: mocha converter root
-- class: root
-- author(s): Primiti_ve, Ice

local logger = require("./roblox_packages/logger")
local types = require("./roblox_packages/types")
local utils = require("./roblox_packages/utils")

local converters = {}

-- automatically get all converter objects
-- this script doesn't need type checking, so we can get away with this
utils.misc.traverse(script, function(instance: Instance)
	if not instance or not instance:IsA("ModuleScript") or instance == script then
		return
	end

	local module = require(instance)

	converters.converters[instance.Name] = module
end)

-- best-guess conversion
-- basically just chooses the first converter that matches
function convert_co(Object: Instance)
	local chosen_converter = nil :: types.converter?

	for _, other_converter: types.converter in pairs(converters) do
		-- we don't need the error
		local success, _ = other_converter.is_convertable(Object)

		if success then
			chosen_converter = other_converter

			break
		end
	end

	if chosen_converter then
		local success, err = nil, nil

		local _ = pcall(function()
			debug.profilebegin(`[converter] convert object of type {chosen_converter.name}`)

			success, err = chosen_converter.convert(Object)

			debug.profileend()
		end)

		if not success and err and typeof(err) == "string" then
			logger:Error(`[converter] {err}`)
		end
	end
end

-- tc tower format to mtk tower format converter
function convert_tower(Tower: Instance)
	logger:Warn("tower converting is not implemented!")
end

return {
	converters = converters,

	convert_co = convert_co,
	convert_tower = convert_tower,
}
