-- Set input parameters
local inputs = {
	type = "assembling-machine",
	icon_name = "electrolyser",
	base_entity_name = "assembling-machine-1",
	mod = "angels",
	particles = { ["big"] = 1, ["medium"] = 2 },
	group = "petrochem",
	make_explosions = false,
	make_remnants = false,
}

local tier_map = {
	["nullius-electrolyzer-1"] = { tier = 1 },
	["nullius-electrolyzer-2"] = { tier = 2 },
	["nullius-electrolyzer-3"] = { tier = 3 },
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
	local tier = reskins.lib.tiers.get_tier(map)
	inputs.tint = map.tint or reskins.lib.tiers.get_tint(tier)

	reskins.lib.setup_standard_entity(name, tier, inputs)
end
