local boiler = require("base/boiler")

local tier_map = {
	["nullius-combustion-chamber-1"] = { tier = 1, prog_tier = 1 },
	["nullius-combustion-chamber-2"] = { tier = 2, prog_tier = 2 },
	["nullius-combustion-chamber-3"] = { tier = 3, prog_tier = 3 },
}

for name, map in pairs(tier_map) do
	boiler(
		name,
		(reskins.lib.settings.get_value("reskins-lib-tier-mapping") == "progression-map") and map.prog_tier or map.tier
	)
end
