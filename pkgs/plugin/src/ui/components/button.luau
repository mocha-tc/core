local fusion = require("../../../roblox_packages/Fusion")

local peek = fusion.peek
local OnEvent, Children = fusion.OnEvent, fusion.Children

type scope<T> = fusion.Scope<T>
type used_as<T> = fusion.UsedAs<T>
type child = fusion.Child

local COLOUR_BLACK = Color3.new(0, 0, 0)
local COLOUR_WHITE = Color3.new(1, 1, 1)

local COLOUR_TEXT = COLOUR_WHITE
local COLOUR_BG_REST = Color3.fromHex("#ffffff")
local COLOUR_BG_HOVER = COLOUR_BG_REST:Lerp(COLOUR_BLACK, 0.15)
local COLOUR_BG_HELD = COLOUR_BG_REST:Lerp(COLOUR_BLACK, 0.25)
local COLOUR_BG_DISABLED = Color3.fromHex("CCCCCC")

local BG_FADE_SPEED = 35

local CORNER_RADIUS = UDim.new(0, 4)
local PADDING = UDim2.fromOffset(6, 4)

return function(
	scope: scope<typeof(fusion)>,
	props: {
		Name: used_as<string>?,
		Parent: used_as<Instance>,

		LayoutOrder: used_as<number>?,
		Position: used_as<UDim2>?,
		AnchorPoint: used_as<Vector2>?,
		ZIndex: used_as<number>?,
		Size: used_as<UDim2>?,
		AutomaticSize: used_as<Enum.AutomaticSize>?,

		Text: used_as<string>?,
		disabled: used_as<boolean>?,
		on_click: (() -> ())?,
	}
): child
	local is_hovering = scope:Value(false)
	local is_held_down = scope:Value(false)

	return scope:New("TextButton")({
		Name = props.Name,
		Parent = props.Parent,

		LayoutOrder = props.LayoutOrder or 1,
		Position = props.Position or UDim2.fromOffset(0, 0),
		AnchorPoint = props.AnchorPoint or Vector2.new(0, 0),
		ZIndex = props.ZIndex or 1,
		Size = props.Size or UDim2.fromOffset(200, 50),
		AutomaticSize = props.AutomaticSize or Enum.AutomaticSize.None,

		Text = props.Text,
		TextColor3 = COLOUR_TEXT,

		BackgroundColor3 = scope:Spring(
			scope:Computed(function(use)
				return if use(props.disabled)
					then COLOUR_BG_DISABLED
					elseif use(is_held_down) then COLOUR_BG_HELD
					elseif use(is_hovering) then COLOUR_BG_HOVER
					else COLOUR_BG_REST
			end),

			BG_FADE_SPEED
		),

		[OnEvent("Activated")] = function()
			if props.on_click ~= nil and not peek(props.disabled) then
				props.on_click()
			end
		end,

		[OnEvent("MouseButton1Down")] = function()
			is_held_down:set(true)
		end,
		[OnEvent("MouseButton1Up")] = function()
			is_held_down:set(false)
		end,

		[OnEvent("MouseEnter")] = function()
			is_hovering:set(true)
		end,
		[OnEvent("MouseLeave")] = function()
			is_held_down:set(false)
			is_hovering:set(false)
		end,

		[Children] = {
			scope:New("UICorner")({
				CornerRadius = CORNER_RADIUS,
			}),

			scope:New("UIPadding")({
				PaddingTop = PADDING.Y,
				PaddingBottom = PADDING.Y,
				PaddingLeft = PADDING.X,
				PaddingRight = PADDING.X,
			}),
		},
	})
end
