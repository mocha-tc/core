-- name: Properties
-- description: brush property map
-- class: manifest
-- author(s): Primiti_ve

local property_map = {
	BackgroundColor3 = "Background",
	ScrollBarImageColor3 = "ScrollBar",

	TextColor3 = "Text",
	ImageColor3 = "Image",
}

local valid_types = {
	"string",
	"number",
	"Color3",
	"boolean",
}

return {
	property_map = property_map,
	valid_types = valid_types,
}
