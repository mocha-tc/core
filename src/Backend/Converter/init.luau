-- name: converter
-- description: mocha converter root
-- class: root
-- author(s): Primiti_ve, Ice

local Root = script:FindFirstAncestor("Mocha")
local Common = Root:WaitForChild("Common")

local Logger = require(Common:WaitForChild("Exports"):WaitForChild("Logger"))

local Converters = {}

export type Converter = {
	name: string,

	isConvertable: (Instance) -> (boolean, string?),
	convert: (Instance) -> Instance,
}

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
function convert(Object: Instance)
	local ChosenConverter = nil :: Converter?

	for _, OtherConverter: Converter in pairs(Converters) do
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

return {
	Converters = Converters,
	convert = convert,
}
