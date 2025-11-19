-- name: Converter
-- description: mocha converter root
-- class: converter
-- author(s): Primiti_ve, Ice

local Logger = require("./roblox_packages/Logger")
local Types = require("./roblox_packages/Types")

local Converters = {}

-- automatically get all converter objects
-- this script doesn't need type checking, so we can get away with this
function Traverse(Parent: Instance)
	if Parent:IsA("Folder") then
		for _, Child in pairs(Parent:GetChildren()) do
			Traverse(Child)
		end
	elseif Parent:IsA("ModuleScript") and Parent ~= script then
		local Module = require(Parent)

		Converter.Converters[Parent.Name] = Module
	end
end

Traverse(script)

-- best-guess conversion
-- basically just chooses the first converter that matches
function convert_co(Object: Instance)
	local ChosenConverter = nil :: Types.Converter?

	for _, OtherConverter: Types.Converter in pairs(Converters) do
		local Success, _Error = OtherConverter.isConvertable(Object)

		if Success then
			ChosenConverter = OtherConverter

			break
		end
	end

	if ChosenConverter then
		local Success, Error = nil, nil

		local _ = pcall(function()
			debug.profilebegin(`[converter] convert object of type {ChosenConverter.name}`)

			Success, Error = ChosenConverter.convert(Object)

			debug.profileend()
		end)

		if not Success and Error and typeof(Error) == "string" then
			Logger:Error(`[converter] {Error}`)
		end
	end
end

-- tc tower format to mtk tower format converter
function convert_tower(Tower: Instance) end

return {
	Converters = Converters,

	convert_co = convert_co,
	convert_tower = convert_tower,
}
