local _framework = { tiers = require("__reskins-framework__.api.tiers") }

local entities = {
	["splitter"] = { type = "splitter", tier = 1, prog_tier = 1 },
	["fast-splitter"] = { type = "splitter", tier = 2, prog_tier = 2 },
	["express-splitter"] = { type = "splitter", tier = 3, prog_tier = 3 },
	["bob-ultimate-splitter"] = { type = "splitter", tier = 4, prog_tier = 4 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	_framework.tiers.add_tier_labels_to_prototype(tier, entity)

	::continue::
end
