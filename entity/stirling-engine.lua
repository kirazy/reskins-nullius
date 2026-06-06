local steam_engine = require("base/steam-engine")

local tier_map = {
	["nullius-stirling-engine-1"] = { tier = 1, prog_tier = 1 },
	["nullius-stirling-engine-2"] = { tier = 2, prog_tier = 2 },
	["nullius-stirling-engine-3"] = { tier = 3, prog_tier = 3 },
}

for name, map in pairs(tier_map) do
	steam_engine(
		name,
		(reskins.lib.settings.get_value("reskins-lib-tier-mapping") == "progression-map") and map.prog_tier or map.tier
	)
end

data.raw["animation"]["nullius-stirling-vertical-turbine-1"].layers = { util.empty_animation(1) }
data.raw["animation"]["nullius-stirling-vertical-turbine-2"].layers = { util.empty_animation(1) }
data.raw["animation"]["nullius-stirling-vertical-turbine-3"].layers = { util.empty_animation(1) }
