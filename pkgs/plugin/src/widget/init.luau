-- name: Widget
-- description: plugin widget/toolbar management
-- class: utility
-- author(s): Primiti_ve

local Utils = require("../roblox_packages/Utils")

local Widget = {}
Widget.__index = Widget

function Widget.new(WidgetTitle: string, WidgetSize: Vector2)
	local self = setmetatable({}, Widget)

	self.WidgetTitle = WidgetTitle

	self.WidgetInfo = DockWidgetPluginGuiInfo.new(
		Enum.InitialDockState.Float,
		false,
		false,
		WidgetSize.X,
		WidgetSize.Y,
		WidgetSize.X,
		WidgetSize.Y
	)

	return self
end

function Widget:CreateWidget(FromGUI: Instance?)
	if self.Widget or not self.WidgetTitle or not self.WidgetInfo then
		return self
	end

	local plugin = Utils.PluginGlobal.get()

	if not plugin then
		return self
	end

	self.Widget = plugin:CreateDockWidgetPluginGui(self.WidgetTitle, self.WidgetInfo)

	if FromGUI then
		for _, Child in pairs(FromGUI:GetChildren()) do
			Child.Parent = self.Widget
		end

		FromGUI:Destroy()
	end

	return self
end

function Widget:Get(Name: string)
	if Name == "Widget" then
		if not self.Widget then
			return nil
		end

		return self.Widget
	end

	return nil
end

function Widget:CreateToolbar(ToolbarTitle: string)
	if self.Toolbar then
		return self
	end

	local plugin = Utils.PluginGlobal.get()

	if not plugin then
		return self
	end

	self.Toolbar = plugin:CreateToolbar(ToolbarTitle)

	return self
end

function Widget:CreateButton(ButtonName: string, ButtonDescription: string, ButtonIcon: string)
	if not self.Toolbar or self.Button then
		return self
	end

	local plugin = Utils.PluginGlobal.get()

	if not plugin then
		return self
	end

	self.Button = self.Toolbar:CreateButton(ButtonName, ButtonDescription, ButtonIcon)
	self.Button.ClickableWhenViewportHidden = true

	self.Button.Click:Connect(function()
		if self.Widget then
			self.Widget.Enabled = not self.Widget.Enabled
		end
	end)

	return self
end

function Widget:AppendToWidget(Object: Instance)
	if not self.Widget then
		return self
	end

	local plugin = Utils.PluginGlobal.get()

	if not plugin then
		return self
	end

	local Clone = Object:Clone()

	Clone.Parent = self.Widget

	return self
end

return Widget
