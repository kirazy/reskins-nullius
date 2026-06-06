local boiler = require("base/boiler")

local tier_map = {
	["nullius-boiler-1"] = { tier = 1, prog_tier = 4 },
	["nullius-boiler-2"] = { tier = 2, prog_tier = 5 },
}

for name, map in pairs(tier_map) do
	boiler(
		name,
		(reskins.lib.settings.get_value("reskins-lib-tier-mapping") == "progression-map") and map.prog_tier or map.tier
	)

	local item = data.raw.item[name]
	if item then
		item.icons[3].tint = util.get_color_with_alpha(reskins.lib.tiers.get_tint(map.prog_tier), 0.75)
	end
end
