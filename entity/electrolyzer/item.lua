-- cspell: words electrolyser electrolyzer
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

local tier_map = {
	["nullius-electrolyzer-1"] = { tier = 1 },
	["nullius-electrolyzer-2"] = { tier = 2 },
	["nullius-electrolyzer-3"] = { tier = 3 },
}

-- Reskin entities, create and assign extra details.
for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)
	---@type LibHack.SetupStandardEntityInputs
	local inputs = {
		type = "assembling-machine",
		icon_name = "electrolyser",
		base_entity_name = "assembling-machine-1",
		graphics_mod = "assets-angels",
		particles = { ["big"] = 1, ["medium"] = 2 },
		make_explosions = false,
		make_remnants = false,
		tint = _framework.tiers.get_tint(tier),
	}

	_lib.setup_standard_entity(name, tier, inputs)
end
