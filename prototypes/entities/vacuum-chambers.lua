local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Liquefier = require("__reskins-assets-api__.assets.angels.entities.refining.liquefier")

if not mods["lambent-nil"] then
	return
end

local entities = {
	["nullius-vacuum-chamber-1"] = { tier = 1 },
	["nullius-vacuum-chamber-2"] = { tier = 2 },
	["nullius-vacuum-chamber-3"] = { tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw["assembling-machine"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = Liquefier.get_sprite_set({ tint = tint })
	Applicators.apply_sprite_set(entity, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		composition = Liquefier.get_icon_composition({ tint = tint }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
