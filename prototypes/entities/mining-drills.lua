---@using data

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local ElectricMiningDrill = require("__reskins-assets-api__.assets.base.entities.mining-drill-electric")
local TallElectricMiningDrill = require("__reskins-assets-api__.assets.assorted.entities.mining-drill-electric-tall")

local small_icon_scale = 0.8
local medium_icon_scale = 0.9

local entities = {
	["nullius-small-miner-2"] = {
		tier = 2,
		prog_tier = 2,
		icon_scalar = small_icon_scale,
		get_sprite_set = ElectricMiningDrill.get_sprite_set,
		get_icon_composition = ElectricMiningDrill.get_icon_composition,
	},
	["nullius-small-miner-3"] = {
		tier = 3,
		prog_tier = 3,
		icon_scalar = small_icon_scale,
		get_sprite_set = ElectricMiningDrill.get_sprite_set,
		get_icon_composition = ElectricMiningDrill.get_icon_composition,
	},
	["nullius-medium-miner-2"] = {
		tier = 2,
		prog_tier = 3,
		icon_scalar = medium_icon_scale,
		get_sprite_set = ElectricMiningDrill.get_sprite_set,
		get_icon_composition = ElectricMiningDrill.get_icon_composition,
	},
	["nullius-medium-miner-3"] = {
		tier = 3,
		prog_tier = 4,
		icon_scalar = medium_icon_scale,
		get_sprite_set = ElectricMiningDrill.get_sprite_set,
		get_icon_composition = ElectricMiningDrill.get_icon_composition,
	},
	["nullius-large-miner-1"] = {
		tier = 2,
		prog_tier = 4,
		get_sprite_set = TallElectricMiningDrill.get_sprite_set,
		get_icon_composition = TallElectricMiningDrill.get_area_icon_composition,
		frame = "blue",
	},
	["nullius-large-miner-2"] = {
		tier = 3,
		prog_tier = 5,
		get_sprite_set = TallElectricMiningDrill.get_sprite_set,
		get_icon_composition = TallElectricMiningDrill.get_area_icon_composition,
		frame = "blue",
	},
}

for name, options in pairs(entities) do
	local entity = data.raw["mining-drill"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = options.get_sprite_set({
		tint = tint,
		frame = options.frame,
		animation_speed = entity.mining_speed,
	})

	Applicators.apply_sprite_set(entity, sprite_set)

	local composition = options.get_icon_composition({ tint = tint })
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		composition = options.icon_scalar and composition:minify(options.icon_scalar) or composition,
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end

local burner_entities = {
	["nullius-small-miner-1"] = {
		tier = 1,
		prog_tier = 1,
		icon_scalar = small_icon_scale,
	},
	["nullius-medium-miner-1"] = {
		tier = 1,
		prog_tier = 2,
		icon_scalar = medium_icon_scale,
	},
}

local burner_icon = { { icon = "__base__/graphics/icons/burner-mining-drill.png" } }

for name, options in pairs(burner_entities) do
	local entity = data.raw["mining-drill"][name]
	if entity then
		local tier = _framework.tiers.get_tier(options)

		local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
			tier = tier,
			name = entity.name,
			type_name = entity.type,
			icon_data = _sprite_utils.icons.minify_icon(burner_icon, options.icon_scalar),
		})

		_sprite_utils.icons.apply_icon_assignment(icon_assignment)
	end
end
