-- Set input parameters
local inputs = {
	type = "mining-drill",
	icon_name = "chemical-furnace",
	base_entity_name = "oil-refinery",
	mod = "angels",
	particles = { ["big-tint"] = 5, ["medium"] = 2 },
	group = "smelting",
	make_explosions = false,
	make_remnants = false,
}

local tier_map = {
	["nullius-geothermal-plant-1"] = { tier = 1, prog_tier = 1 },
	["nullius-geothermal-plant-2"] = { tier = 2, prog_tier = 2 },
	["nullius-geothermal-plant-3"] = { tier = 3, prog_tier = 3 },
}

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
	local tier = reskins.lib.tiers.get_tier(map)
	inputs.tint = map.tint or reskins.lib.tiers.get_tint(tier)

	reskins.lib.setup_standard_entity(name, tier, inputs)
end
