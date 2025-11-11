-- name: Spinner
-- description: spinner conversion script
-- class: converter
-- author(s): Ice, Primiti_ve

local defaultSpinningPlatform = script:WaitForChild("Original")

-- tower creator spinning part
-- adding comments here cuz i know i'm gonna forget everything in 3 seconds
-- (basically none of these values are used in the actual client object, for context -prim)
export type SpinningPart = Model & {
	-- Axis
	A: StringValue & { Value: "X" | "Y" | "Z" },

	-- Anchored
	Anchor: BoolValue,

	-- Stick
	-- (like if the player moves with it while on it)
	-- (obsolete value? roblox physics does that anyway, iirc -prim)
	S: BoolValue,

	-- Time
	-- (to complete one full rotation)
	T: NumberValue,

	-- Anchor Angle
	aA: BoolValue,

	-- X Offset
	xO: NumberValue,

	-- Y Offset
	yO: NumberValue,

	-- Z Offset
	zO: NumberValue,

	Base: Part,
	Part: Part,
}

-- etoh v5.5 spinning platform
export type SpinningPlatform = typeof(defaultSpinningPlatform)

function isConvertable(Model: Model): (boolean, string?)
	if not Model or not Model:IsA("Model") then
		return false, "model is missing or not a Model"
	end

	if
		(not Model:FindFirstChild("Base") or not Model.Base:IsA("BasePart"))
		or (not Model:FindFirstChild("Part") or not Model.Part:IsA("BasePart"))
	then
		return false, "model is missing one or more critical components"
	end

	if
		(not Model:FindFirstChild("A") or not Model.A:IsA("StringValue"))
		or (Model.A.Value ~= "X" and Model.A.Value ~= "Y" and Model.A.Value ~= "Z")
	then
		return false, "model is missing A or A is invalid"
	end

	if not Model:FindFirstChild("Anchor") or not Model.Anchor:IsA("BoolValue") then
		return false, ""
	end

	if
		(not Model:FindFirstChild("S") or not Model.S:IsA("BoolValue"))
		or (not Model:FindFirstChild("T") or not Model.T:IsA("NumberValue"))
		or (not Model:FindFirstChild("aA") or not Model.aA:IsA("BoolValue"))
	then
		return false, "model is missing S, T, or aA"
	end

	local axises = { "x", "y", "z" }

	for _, axis in pairs(axises) do
		if not Model:FindFirstChild(axis .. "O") or not Model[axis .. "O"]:IsA("NumberValue") then
			return false, `model is missing {axis}O, or {axis}O is not a NumberValue`
		end
	end

	return true
end

function convert(Model: SpinningPart): SpinningPlatform
	local newSpinner = defaultSpinningPlatform:Clone() :: SpinningPlatform
	local offset = CFrame.new(Model.xO.Value, Model.yO.Value, Model.zO.Value)

	newSpinner.Name = "Spinning Platform"

	newSpinner.Primary.CFrame = Model.Base.CFrame
	newSpinner.Motor.CFrame = Model.Base.CFrame

	local spinPart = Model.Part:Clone() :: Part

	spinPart.Anchored = false
	spinPart.CFrame = newSpinner.Motor.CFrame:ToWorldSpace(offset)
	spinPart.Parent = newSpinner

	local WeldConstraint = Instance.new("WeldConstraint")

	WeldConstraint.Part0 = spinPart

	if Model.aA.Value then
		-- basically welded a second spinner to the first one with the offset and rotates the platform the opposite direction
		local secondPrimary = newSpinner.Primary:Clone()

		secondPrimary.CFrame = spinPart.CFrame
		secondPrimary.Name = "secondPrimary"
		secondPrimary.Anchored = false
		secondPrimary.Parent = newSpinner

		local secondMotor = newSpinner.Motor:Clone()

		secondMotor.CFrame = spinPart.CFrame
		secondMotor.Name = "secondMotor"
		secondMotor.Parent = newSpinner

		secondPrimary.CylindricalConstraint.Attachment1 = secondMotor.Attachment1
		secondPrimary.CylindricalConstraint.AngularVelocity *= -1

		local secondWeldConstraint = Instance.new("WeldConstraint")

		secondWeldConstraint.Enabled = false
		secondWeldConstraint.Part0 = secondPrimary
		secondWeldConstraint.Part1 = newSpinner.Motor
		secondWeldConstraint.Name = "secondWeldConstraint"
		secondWeldConstraint.Parent = secondPrimary
		secondWeldConstraint.Enabled = true

		WeldConstraint.Part1 = secondMotor
	else
		WeldConstraint.Part1 = newSpinner.Motor
	end

	WeldConstraint.Parent = spinPart
	WeldConstraint.Enabled = true

	newSpinner.Parent = Model.Parent
	Model:Destroy()

	return newSpinner
end

return {
	name = "spinner",

	convert = convert,
	isConvertable = isConvertable,
}
