-- name: misc
-- description: anything utils-related that doesn't fit into any of the other categories
-- class: utility
-- author(s): Primiti_ve

function traverse(root: Instance, parse_fn: (Instance) -> ())
	if root:IsA("Folder") then
		for _, Child in pairs(root:GetChildren()) do
			traverse(Child, parse_fn)
		end
	else
		parse_fn(root)
	end
end

return {
	traverse = traverse,
}
