local heat_exchanger = require("base/heat-exchanger")

local tier_map = {
	["nullius-heat-exchanger-1"] = { tier = 1, prog_tier = 1 },
	["nullius-heat-exchanger-2"] = { tier = 2, prog_tier = 2 },
	["nullius-heat-exchanger-3"] = { tier = 3, prog_tier = 3 },
}

for name, map in pairs(tier_map) do
	heat_exchanger(
		name,
		(reskins.lib.settings.get_value("reskins-lib-tier-mapping") == "progression-map") and map.prog_tier or map.tier
	)
end
