-- name: Property
-- description: property utils
-- class: utility
-- author(s): Primiti_ve

local PropertyCache = {}

function HasProperty(Object: Instance, Property: string)
	local ClassName = Object.ClassName
	local ClassCache = PropertyCache[ClassName]

	-- if cache already has property, return that instead
	if ClassCache and ClassCache[Property] ~= nil then
		return ClassCache[Property]
	end

	-- check if object has property
	local Success = pcall(function()
		return Object[Property]
	end)

	-- add it to the cache
	PropertyCache[ClassName] = PropertyCache[ClassName] or {}
	PropertyCache[ClassName][Property] = Success

	return Success
end

return {
	_PropertyCache = PropertyCache,

	HasProperty = HasProperty,
}
