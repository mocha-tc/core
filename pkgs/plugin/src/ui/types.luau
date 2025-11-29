local fusion = require("../../roblox_packages/fusion")

export type story_controls = { [string]: any }
export type story_cleanup = () -> ()

export type story_props = {
	controls: story_controls | {},
	target: Instance,
}

export type story = {
	fusion: typeof(fusion),
	controls: story_controls?,

	story: (story_props) -> story_cleanup?,
}

return nil
