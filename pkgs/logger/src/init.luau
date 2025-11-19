-- name: Logger
-- description: Mocha's logger
-- class: export
-- author(s): Primiti_ve

local luaulog = require("./roblox_packages/luaulog")
local Logger = luaulog.Logger.new({
	luaulog.Common.Enrichers.LogLevelEnricher(),
	luaulog.Common.Enrichers.DynSourceEnricher(true),
	luaulog.Common.Enrichers.TraceEnricher(),
}, { luaulog.Common.RobloxLogSink() })

return Logger