-- name: Logger
-- description: Mocha's logger
-- class: export
-- author(s): Primiti_ve

local Root = script:FindFirstAncestor("Mocha")
local Packages = Root:WaitForChild("Packages")

local luaulog = require(Packages:WaitForChild("luaulog"))
local Logger = luaulog.Logger.new({
	luaulog.Common.Enrichers.LogLevelEnricher(),
	luaulog.Common.Enrichers.DynSourceEnricher(true),
	luaulog.Common.Enrichers.TraceEnricher(),
}, { luaulog.Common.RobloxLogSink() })

return Logger