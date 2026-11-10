local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Lab = require("__reskins-assets-api__.assets.base.entities.lab")
local Tints = require("__reskins-nullius__.prototypes.tints")

local entities = {
	["nullius-lab-1"] = { tier = 1, prog_tier = 1, icon_scalar = 0.8 },
	["nullius-lab-2"] = { tier = 2, prog_tier = 2, icon_scalar = 0.8 },
	["nullius-lab-3"] = { tier = 3, prog_tier = 3, icon_scalar = 0.8 },
	["nullius-biology-lab"] = { tier = 0, tint = Tints.ecological_green },
}

for name, options in pairs(entities) do
	local entity = data.raw["lab"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = options.tint or _framework.tiers.get_tint(tier)

	local sprite_set = Lab.get_sprite_set({ tint = tint })

	Applicators.apply_sprite_set(entity, sprite_set)

	local composition = Lab.get_icon_composition({ tint = tint })
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		composition = options.icon_scalar and composition:minify(options.icon_scalar) or composition,
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
