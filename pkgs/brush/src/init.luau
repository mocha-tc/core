-- name: brush
-- description: colour management
-- class: library
-- author(s): Primiti_ve

local logger = require("./roblox_packages/logger")
local utils = require("./roblox_packages/utils")
local types = require("./roblox_packages/types")

local themes = require("@self/themes")
local properties = require("@self/properties")

local brush = {
	themes = {},
}

local studio_settings = settings().Studio :: types.studio_settings

brush.themes.current_theme = "Studio"

function brush.themes.sync(objects: GuiObject | { GuiObject })
	debug.profilebegin("[brush] sync theme start")

	local object_bins = {}

	objects = if typeof(objects) == "table" then objects else { objects }

	for _, object in pairs(objects) do
		if not object or not object:HasTag("Themed") then
			continue
		end

		local object_bin = utils.bin.new()

		task.spawn(brush.themes.update, object)

		object_bin.add(studio_settings.ThemeChanged:Connect(function()
			task.spawn(brush.themes.update, object)
		end))

		-- used for cleanup
		object_bin.add(object.AncestryChanged:Connect(function(_, new_parent: Instance?)
			if new_parent == nil then
				object_bin.Empty()
			end
		end))

		table.insert(object_bins, object_bin)
	end

	debug.profileend()

	return object_bins
end

function brush.themes.update(object: GuiObject)
	debug.profilebegin("[brush] update theme start")

	local theme_name = brush.themes.current_theme

	if theme_name == "studio" then
		theme_name = studio_settings.Theme.Name
	end

	local theme = themes[theme_name] :: types.theme?

	if not theme then
		logger:Error(`[brush] theme with name {theme_name} not found`)

		return
	end

	local theme_scope = object:GetAttribute("ThemeScope") or "Primary"

	for property, value in pairs(properties.property_map) do
		local theme_entry = theme[value] and theme[value][theme_scope]

		if not theme_entry then
			continue
		end

		if utils.property.has_property(object, property) then
			local current_value = object[property]

			if table.find(properties.valid_types, typeof(current_value)) then
				object[property] = theme_entry
			end
		end
	end

	debug.profileend()
end

return brush
