---@using data

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Lab = require("__reskins-assets-api__.assets.base.entities.lab")

local entities = {
	["nullius-lab-1"] = { tier = 1, prog_tier = 1, icon_scalar = 0.8 },
	["nullius-lab-2"] = { tier = 2, prog_tier = 2, icon_scalar = 0.8 },
	["nullius-lab-3"] = { tier = 3, prog_tier = 3, icon_scalar = 0.8 },
	["nullius-biology-lab"] = { tier = 4, prog_tier = 4 },
}

for name, options in pairs(entities) do
	local entity = data.raw["lab"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(entity.name, {
		base_entity_name = "lab",
		type = entity.type,
		tint = tint,
		particles = {
			["big"] = 3,
		},
	})

	local corpse = _lib.create_remnant(entity.name, {
		base_entity_name = "lab",
		type = entity.type,
	})

	local sprite_set = Lab.get_sprite_set({ tint = tint })

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local icon_data = Lab.get_icon(tint)
	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		icon_data = options.icon_scalar and _sprite_utils.icons.minify_icon(icon_data, options.icon_scalar) or icon_data,
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
