-- name: Types
-- description: shared Mocha types
-- class: utility
-- author(s): Primiti_ve

-- custom type for settings().Studio
export type StudioSettings = typeof(settings().Studio) & {
	ThemeChanged: RBXScriptSignal,
}

return nil
