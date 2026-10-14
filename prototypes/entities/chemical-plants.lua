---@using data

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local ChemicalPlant = require("__reskins-assets-api__.assets.base.entities.chemical-plant")

local entities = {
	["nullius-chemical-plant-1"] = { tier = 1, prog_tier = 1 },
	["nullius-chemical-plant-2"] = { tier = 2, prog_tier = 2 },
	["nullius-chemical-plant-3"] = { tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw["assembling-machine"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(entity.name, {
		base_entity_name = "chemical-plant",
		type = entity.type,
		tint = tint,
		particles = {
			["big"] = 1,
			["medium"] = 2,
		},
	})

	local corpse = _lib.create_remnant(entity.name, {
		base_entity_name = "chemical-plant",
		type = entity.type,
	})

	local sprite_set = ChemicalPlant.get_sprite_set({ tint = tint })

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		icon_data = ChemicalPlant.get_icon({ tint = tint }),
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
