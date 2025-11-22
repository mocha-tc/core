-- name: Types
-- description: shared Mocha types
-- class: utility
-- author(s): Primiti_ve

-- custom type for settings().Studio
-- adds ThemeChanged
export type StudioSettings = typeof(settings().Studio) & {
	ThemeChanged: RBXScriptSignal,
}

-- converter type
export type Converter = {
	name: string,

	isConvertable: (Instance) -> (boolean, string?),
	convert: (Instance) -> Instance,
}

-- brush theme type
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

return nil