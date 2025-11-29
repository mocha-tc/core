-- name: property
-- description: property utils
-- class: utility
-- author(s): Primiti_ve

local property_cache = {}

function has_property(object: Instance, property: string)
	local class_name = object.ClassName
	local class_cache = property_cache[class_name]

	-- if cache already has the property, return that instead
	if class_cache and class_cache[property] ~= nil then
		return class_cache[property]
	end

	-- check if object has the property
	local success = pcall(function()
		return object[property]
	end)

	-- add it to the cache
	property_cache[class_name] = property_cache[class_name] or {}
	property_cache[class_name][property] = success

	return success
end

return {
	has_property = has_property,
}
