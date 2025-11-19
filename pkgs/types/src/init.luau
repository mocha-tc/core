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

return nil