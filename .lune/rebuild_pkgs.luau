local process = require("@lune/process")

for i = 1, 2 do
	print(`[mocha] rebuild packages pass {i}`)

	process.exec("pesde", { "install" }, {
		stdio = "inherit",
	})
end

return nil
