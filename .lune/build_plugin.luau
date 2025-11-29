local fs = require("@lune/fs")
local process = require("@lune/process")

function log(message: string)
	print(`[mocha] {message}`)
end

log("building plugin...")
log("rebuilding packages...")

require("./rebuild_pkgs")

log("packages rebuilt!")
log("creating build directory...")

if not fs.isDir("./build") then
	fs.writeDir("./build")
end

log("build directory created!")
log("building plugin into build directory...")

process.exec("rojo", { "build", "plugin.project.json", "--output", "build/mocha.rbxmx" })

log("plugin built!")
