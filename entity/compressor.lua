local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

---@type LibHack.ConstructIconInputsOld
local inputs = {
	type = "assembling-machine",
	icon_name = "thermal-extractor",
	graphics_mod = "assets-angels",
}

-- Setup defaults.
_lib.set_inputs_defaults(inputs)

local tier_map = {
	["nullius-compressor-1"] = { tier = 1, prog_tier = 1 },
	["nullius-compressor-2"] = { tier = 2, prog_tier = 2 },
	["nullius-compressor-3"] = { tier = 3, prog_tier = 3 },
}

for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)
	inputs.tint = map.tint or _framework.tiers.get_tint(tier)

	_lib.construct_icon(name, tier, inputs)
end
