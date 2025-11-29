-- name: widget
-- description: plugin widget/toolbar management
-- class: utility
-- author(s): Primiti_ve

local utils = require("../roblox_packages/utils")

local widget = {}
widget.__index = widget

function widget.new(widget_title: string, WidgetSize: Vector2)
	local self = setmetatable({}, widget)

	self.widget_title = widget_title

	self.widget_info = DockWidgetPluginGuiInfo.new(
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

function widget:create_widget(base_gui: Instance?)
	if self.widget or not self.widget_title or not self.widget_info then
		return self
	end

	local plugin = utils.plugin_global.get()

	if not plugin then
		return self
	end

	self.widget = plugin:CreateDockWidgetPluginGui(self.widget_title, self.widget_info)

	if base_gui then
		for _, child in pairs(base_gui:GetChildren()) do
			self:append(child)
		end

		base_gui:Destroy()
	end

	return self
end

function widget:get(name: string)
	if name == "widget" then
		if not self.widget then
			return nil
		end

		return self.widget
	end

	return nil
end

function widget:create_toolbar(toolbar_title: string)
	if self.toolbar then
		return self
	end

	local plugin = utils.plugin_global.get()

	if not plugin then
		return self
	end

	self.toolbar = plugin:CreateToolbar(toolbar_title)

	return self
end

function widget:create_button(button_name: string, button_description: string, button_icon: string)
	if not self.toolbar or self.button then
		return self
	end

	local plugin = utils.plugin_global.get()

	if not plugin then
		return self
	end

	self.button = self.toolbar:CreateButton(button_name, button_description, button_icon)
	self.button.ClickableWhenViewportHidden = true

	self.button.Click:Connect(function()
		if self.widget then
			self.widget.Enabled = not self.widget.Enabled
		end
	end)

	return self
end

function widget:append(Object: Instance)
	if not self.widget then
		return self
	end

	local plugin = utils.plugin_global.get()

	if not plugin then
		return self
	end

	local clone = Object:Clone()

	clone.Parent = self.widget

	return self
end

return widget
