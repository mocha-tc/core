-- name: button
-- description: button converter
-- class: converter
-- author(s): native315, Primiti_ve

export type TCButton = Part & {
	S:Folder, --folder that contains object values (named "p") with values tying them to existing parts.
	Sound:Sound, --sound duh
	I:BoolValue, -- invert
	IntTimer:BoolValue, --integer timer (when enabled, will not have decimal points. disabled, the timer will have 2 decimal points.)
	InteractionType:StringValue, --realistically can only be "Plr" or "Push", with "Push" referring to pushboxes and paintballs
	P:BoolValue, -- pressed
	T:NumberValue, -- timer
	aB:BoolValue, --allow balloons
	aC:BoolValue, -- adjust collision (equivalent to "IgnoreCanCollide" tag)
	aKC:BoolValue, -- adjust kb collision (obsolete pretty sure)
	aT:BoolValue, -- adjust transparency (equivalent to "IgnoreTransparency" tag)
	apB:BoolValue, -- allow pushboxes
	apL:BoolValue, -- allow players
	bT:IntValue, -- button texture
	btV:BoolValue, -- button timer visibility
	fH:BoolValue, -- fullhide
	iC:BoolValue, -- instant change
	stV:BoolValue, -- screen timer visibility
}

function is_convertable(Model: Part): (boolean, string?)
	if not Model or not Model:IsA("BasePart") then
		return false, "button is missing or not a BasePart"
	end

	if not Model:FindFirstChild("S") or 
		not Model:FindFirstChild("Sound") or
		not Model:FindFirstChild("I") or
		not Model:FindFirstChild("IntTimer") or
		not Model:FindFirstChild("InteractionType") or
		not Model:FindFirstChild("P") or
		not Model:FindFirstChild("T") or
		not Model:FindFirstChild("aB") or
		not Model:FindFirstChild("aC") or
		not Model:FindFirstChild("aKC") or
		not Model:FindFirstChild("aT") or
		not Model:FindFirstChild("apB") or
		not Model:FindFirstChild("apL") or
		not Model:FindFirstChild("bT") or
		not Model:FindFirstChild("btV") or
		not Model:FindFirstChild("fH") or
		not Model:FindFirstChild("iC") or
		not Model:FindFirstChild("stV") then
		return false, "button is missing one or more critical components"
	end

	return true
end

function convert(Model: TCButton): TCButton 
	--ik this is super stupid and all but the 
	--fundamental structure of how the tc button works is 
	--vastly different than the way the v5.5 button works,       (relating to how tc buttons can activate parts of any color)
	--so i'll just leave it alone for now. 
	--it shouldn't cause problems either way 
	--because the client object script works.

	--if you wanna force the tc button into the v5.5 button, feel free to do so, i just couldn't be bothered to do so

	for i, child in Model.S:GetChildren() do
		local buttonpart = child.Value
		buttonpart.Parent = Model.Parent --object value trauma
	end

	return Model
end

return {
	name = "button",

	convert = convert,
	is_convertable = is_convertable,
}
