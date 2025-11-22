-- name: Mocha
-- description: mocha's root script (or, the entry point)
-- class: root
-- author(s): Primiti_ve

local Converter = require("./roblox_packages/Converter")
local Brush = require("./roblox_packages/Brush")
local Utils = require("./roblox_packages/Utils")

local WidgetClass = require("./src/widget")

function build(PluginGlobal: unknown)
	local GUI = script.assets.GUI:Clone()

	Utils.PluginGlobal.set(PluginGlobal)

	local WidgetSize = Vector2.new(450, 250)
	local CreatedWidget = WidgetClass.new("mocha", WidgetSize)

	CreatedWidget:CreateWidget(GUI)
	CreatedWidget:CreateToolbar("mocha")
	CreatedWidget:CreateButton("mocha", "a tc to v5.5 co converter", "rbxassetid://100158613404254")

	local Widget = CreatedWidget:Get("Widget")

	local Environment = {
		Modules = {
			Brush = Brush,
			Converter = Converter,
		},

		Widget = Widget,

		Exports = {
			PluginGlobal = Utils.PluginGlobal,
		},
	}

	print(GUI)
	print(CreatedWidget)
	print(Widget)

	for _, RunOnSpawn in pairs(Widget:GetDescendants()) do
		if RunOnSpawn:IsA("ModuleScript") and RunOnSpawn:HasTag("RunOnSpawn") then
			task.spawn(require(RunOnSpawn), Environment)
		end
	end
end

return {
	build = build,
}
