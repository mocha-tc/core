-- name: Brush
-- description: colour mnagement
-- class: library
-- author(s): Primiti_ve

local Root = script:FindFirstAncestor("Mocha")
local Common = Root:WaitForChild("Common")

local Types = require(Common:WaitForChild("Types"))

local Logger = require(Common:WaitForChild("Exports"):WaitForChild("Logger"))
local Bin = require(Common:WaitForChild("Modules"):WaitForChild("Bin"))

local Themes = require(script.Themes)
local Properties = require(script.Properties)

local PropertyUtils = require(Common.Utils.Property)

local Brush = {
	Themes = {},
	Internals = {},
}

local StudioSettings = settings().Studio :: Types.StudioSettings

Brush.Themes.CurrentTheme = "Studio"

function Brush.Themes.Sync(Objects: GuiObject | { GuiObject })
	debug.profilebegin("[brush] sync theme start")

	local ObjectBins = {}

	Objects = if typeof(Objects) == "table" then Objects else { Objects }

	for _, Object in pairs(Objects) do
		if not Object or not Object:HasTag("Themed") then
			continue
		end

		local ObjectBin = Bin()

		task.spawn(Brush.Themes.Update, Object)

		ObjectBin.Add(StudioSettings.ThemeChanged:Connect(function()
			task.spawn(Brush.Themes.Update, Object)
		end))

		-- used for cleanup
		ObjectBin.Add(Object.AncestryChanged:Connect(function(_, NewParent: Instance?)
			if NewParent == nil then
				ObjectBin.Empty()
			end
		end))

		table.insert(ObjectBins, ObjectBin)
	end

	debug.profileend()

	return ObjectBins
end

function Brush.Themes.Update(Object: GuiObject)
	debug.profilebegin("[brush] update theme start")

	local ThemeName = Brush.Themes.CurrentTheme

	if ThemeName == "Studio" then
		ThemeName = StudioSettings.Theme.Name
	end

	local Theme = Themes[ThemeName] :: Themes.Theme?

	if not Theme then
		Logger:Error(`[brush] theme with name {ThemeName} not found`)

		return
	end

	local ThemeScope = Object:GetAttribute("ThemeScope") or "Primary"

	for Property, Value in pairs(Properties.PropertyMap) do
		local ThemeEntry = Theme[Value] and Theme[Value][ThemeScope]

		if not ThemeEntry then
			continue
		end

		if PropertyUtils.HasProperty(Object, Property) then
			local CurrentValue = Object[Property]

			if table.find(Properties.ValidTypes, typeof(CurrentValue)) then
				Object[Property] = ThemeEntry
			end
		end
	end

	debug.profileend()
end

return Brush
