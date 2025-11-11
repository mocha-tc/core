-- name: Mocha
-- description: mocha's root script (or, the entry point)
-- class: root
-- author(s): Primiti_ve

local GUI = script.Common.Assets.GUI:Clone()
local PluginGlobal = require(script.Common.Exports.PluginGlobal)

PluginGlobal.set(plugin)

local Converter = require(script.Backend.Converter)

local WidgetClass = require(script.Frontend.Widget)
local Brush = require(script.Frontend.Brush)

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
		PluginGlobal = PluginGlobal,
	},
}

for _, RunOnSpawn in pairs(Widget:GetDescendants()) do
	if RunOnSpawn:IsA("ModuleScript") and RunOnSpawn:HasTag("RunOnSpawn") then
		task.spawn(require(RunOnSpawn), Environment)
	end
end
