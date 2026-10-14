local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

local tier_map = {
	["nullius-geothermal-plant-1"] = { tier = 1, prog_tier = 1 },
	["nullius-geothermal-plant-2"] = { tier = 2, prog_tier = 2 },
	["nullius-geothermal-plant-3"] = { tier = 3, prog_tier = 3 },
}

-- Reskin entities, create and assign extra details.
for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)

	---@type LibHack.SetupStandardEntityInputs
	local inputs = {
		type = "mining-drill",
		icon_name = "chemical-furnace",
		base_entity_name = "oil-refinery",
		graphics_mod = "assets-angels",
		particles = { ["big-tint"] = 5, ["medium"] = 2 },
		make_explosions = false,
		make_remnants = false,
		tint = _framework.tiers.get_tint(tier),
	}

	_lib.setup_standard_entity(name, tier, inputs)
end
