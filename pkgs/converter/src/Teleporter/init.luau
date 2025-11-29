-- name: teleporter
-- description: teleporter converter
-- class: converter
-- author(s): Native, Primiti_ve

-- tower creator teleporter
-- adding comments here cuz i know i'm gonna forget everything in 3 seconds
export type TCTeleporter = Model & {
	-- move effect
	mE: BoolValue,

	-- move effect time
	mT: NumberValue,

	-- tp players
	tP: BoolValue,

	-- tp pboxes
	tPB: BoolValue,

	-- is it a winpad?
	-- (this value should never be used in an actual game... why do they even export this?? -prim)
	wP: BoolValue,

	destination: BasePart,
	Telepart: BasePart,
}

-- etoh v5.5 teleporter
export type V5Teleporter = typeof(script:WaitForChild("Original"))

function is_convertable(Model: Model): (boolean, string?)
	if not Model or not Model:IsA("Model") then
		return false, "model is missing or not a Model"
	end

	if
		(not Model:FindFirstChild("Des") or not Model.Des:IsA("BasePart"))
		or (not Model:FindFirstChild("TP") or not Model.TP:IsA("BasePart"))
	then
		return false, "model is missing one or more critical components"
	end

	return true
end

function convert(Model: TCTeleporter): V5Teleporter
	local newtp = script.Original:Clone() :: V5Teleporter

	newtp.Name = "Teleporter"

	Model.destination.Name = "Destination"
	Model.destination:FindFirstChildOfClass("Sound").Name = "TeleportSound"
	Model.destination.Parent = newtp

	Model.Telepart.Name = "Teleporter"
	Model.Telepart.Parent = newtp

	newtp.Destination:Destroy()
	newtp.Teleporter:Destroy()

	newtp.TransitionTime.Value = if Model.mE then Model.mT else 0
	newtp.TeleportPlayers.Value = Model.tP.Value
	newtp.TeleportPushboxes.Value = Model.tPB.Value
	newtp.Winpad.Value = Model.wP.Value

	newtp.Parent = Model.Parent

	return newtp
end

return {
	name = "teleporter",

	convert = convert,
	is_convertable = is_convertable,
}
