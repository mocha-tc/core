-- name: Themes
-- description: brush themes
-- class: utility
-- author(s): Primiti_ve

export type Theme = {
	Background: {
		Primary: Color3,
		Secondary: Color3,
	},

	ScrollBar: {
		Primary: Color3,
	},

	Text: {
		Primary: Color3,
		Secondary: Color3,

		Warn: Color3,
		Error: Color3,
	},

	Image: {
		Primary: Color3,
		Secondary: Color3,
	},
}

local Themes = {
	Dark = {
		Background = {
			Primary = Color3.fromRGB(20, 20, 20),
			Secondary = Color3.fromRGB(50, 50, 50),
		},

		ScrollBar = {
			Primary = Color3.fromRGB(255, 255, 255),
		},

		Text = {
			Primary = Color3.fromRGB(255, 255, 255),
			Secondary = Color3.fromRGB(200, 200, 200),

			Warn = Color3.fromRGB(255, 238, 110),
			Error = Color3.fromRGB(255, 99, 99),
		},

		Image = {
			Primary = Color3.fromRGB(255, 255, 255),
			Secondary = Color3.fromRGB(200, 200, 200),
		},
	},

	Light = {
		Background = {
			Primary = Color3.fromRGB(235, 235, 235),
			Secondary = Color3.fromRGB(180, 180, 180),
		},

		ScrollBar = {
			Primary = Color3.fromRGB(0, 0, 0),
		},

		Text = {
			Primary = Color3.fromRGB(0, 0, 0),
			Secondary = Color3.fromRGB(50, 50, 50),

			Warn = Color3.fromRGB(255, 238, 110),
			Error = Color3.fromRGB(255, 99, 99),
		},

		Image = {
			Primary = Color3.fromRGB(0, 0, 0),
			Secondary = Color3.fromRGB(50, 50, 50),
		},
	},
} :: { [string]: Theme }

return Themes
