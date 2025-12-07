-- name: elevator
-- description: elevator converter
-- class: converter
-- author(s): native315, Primiti_ve

-- tower creator elevator
-- adding comments here cuz i know i'm gonna forget everything in 3 seconds
export type TCElevator = Part & { -- like 99% sure it's a part because you can't make a truss elevator in tc
	-- ignore boxes (unused)
	IgnoreBoxes: BoolValue,

	-- ignore players (unused)
	IgnorePlayers: BoolValue,

	-- liftvelocity 
	LiftVelocity: NumberValue,
}

-- etoh v5.5 teleporter
export type V5Elevator = typeof(script:WaitForChild("Original"))

function is_convertable(Model: Part): (boolean, string?)
	if not Model or not Model:IsA("BasePart") then
		return false, "elevator is missing or not a BasePart"
	end

	if not Model:FindFirstChild("LiftVelocity") then
		return false, "elevator is missing one or more critical components"
	end

	return true
end

function convert(Model: TCElevator): V5Elevator
	local newelevator = script.Original:Clone() :: V5Elevator

	newelevator.Name = "Elevator"


	--MY EYES
	newelevator.Color = Model.Color
	newelevator.Material = Model.Material
	newelevator.MaterialVariant = Model.MaterialVariant
	newelevator.Reflectance = Model.Reflectance
	newelevator.Transparency = Model.Transparency
	newelevator.Parent = Model.Parent
	newelevator.Size = Model.Size
	newelevator.CFrame = Model.CFrame
	newelevator.CanCollide = Model.CanCollide
	newelevator.Anchored = Model.Anchored
	newelevator.Shape = Model.Shape
	newelevator.BackSurface = Model.BackSurface
	newelevator.FrontSurface = Model.FrontSurface
	newelevator.TopSurface = Model.TopSurface
	newelevator.BottomSurface = Model.BottomSurface
	newelevator.RightSurface = Model.RightSurface
	newelevator.LeftSurface = Model.LeftSurface

	newelevator.Speed.Value = Model.LiftVelocity.Value

	Model:Destroy()

	return newelevator
end

return {
	name = "elevator",

	convert = convert,
	is_convertable = is_convertable,
}
