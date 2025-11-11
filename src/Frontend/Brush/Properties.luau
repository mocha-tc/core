-- name: Properties
-- description: brush property map
-- class: utility
-- author(s): Primiti_ve

local PropertyMap = {
	BackgroundColor3 = "Background",
	ScrollBarImageColor3 = "ScrollBar",

	TextColor3 = "Text",
	ImageColor3 = "Image",
}

local ValidTypes = {
	"string",
	"number",
	"Color3",
	"boolean",
}

return {
	PropertyMap = PropertyMap,
	ValidTypes = ValidTypes,
}
