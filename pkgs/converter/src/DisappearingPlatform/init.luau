-- name: disappearing platform
-- description: disappearing platform converter
-- class: converter
-- author(s): native315, Primiti_ve

export type TCDisappearingPlatform = Part & {
	EffectColor: Color3Value, --the color the outline turns after it disappears
	fE: BoolValue, -- fade effect
	fT: NumberValue, -- fade time
	rT: NumberValue, -- respawn time
	SelectionBox: SelectionBox, -- selection box
}

-- etoh v5.5 disappearingplatform
export type V5DisappearingPlatform = typeof(script:WaitForChild("Original"))

local original = script:WaitForChild("Original") :: Instance

function is_convertable(Model: Part): (boolean, string?)
	if not Model or not Model:IsA("BasePart") then
		return false, "disappearing platform is missing or not a BasePart"
	end

	if
		not Model:FindFirstChild("EffectColor")
		or not Model:FindFirstChild("fE")
		or not Model:FindFirstChild("fT")
		or not Model:FindFirstChild("rT")
	then
		return false, "disappearing platform is missing one or more critical components"
	end

	return true
end

function convert(Model: TCDisappearingPlatform): V5DisappearingPlatform
	local newdp = original:Clone() :: V5DisappearingPlatform

	newdp.Name = "DisappearingPlatform"

	newdp.EffectColor.Value = Model.EffectColor.Value
	newdp.FadeTime.Value = Model.fT.Value
	newdp.RespawnTime.Value = Model.rT.Value
	newdp.FadeEffect.Value = Model.fE.Value
	newdp.SelectionBox.Color3 = Model.SelectionBox.Color3

	Model:ClearAllChildren()
	for i, child in newdp:GetChildren() do
		child.Parent = Model
	end

	newdp:Destroy()

	return Model
end

return {
	name = "disappearing platform",

	convert = convert,
	is_convertable = is_convertable,
}
