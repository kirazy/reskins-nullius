local tier_map = {
	["nullius-chemical-plant-1"] = { tier = 1, prog_tier = 1 },
	["nullius-chemical-plant-2"] = { tier = 2, prog_tier = 2 },
	["nullius-chemical-plant-3"] = { tier = 3, prog_tier = 3 },
}

for name, map in pairs(tier_map) do
	reskins.lib.apply_skin.chemical_plant(
		name,
		(reskins.lib.settings.get_value("reskins-lib-tier-mapping") == "progression-map") and map.prog_tier or map.tier
	)
end
