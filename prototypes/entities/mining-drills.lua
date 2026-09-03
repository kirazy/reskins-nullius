---@using data

local _lib = require("_lib")
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
		get_icon = ElectricMiningDrill.get_icon,
	},
	["nullius-small-miner-3"] = {
		tier = 3,
		prog_tier = 3,
		icon_scalar = small_icon_scale,
		get_sprite_set = ElectricMiningDrill.get_sprite_set,
		get_icon = ElectricMiningDrill.get_icon,
	},
	["nullius-medium-miner-2"] = {
		tier = 2,
		prog_tier = 3,
		icon_scalar = medium_icon_scale,
		get_sprite_set = ElectricMiningDrill.get_sprite_set,
		get_icon = ElectricMiningDrill.get_icon,
	},
	["nullius-medium-miner-3"] = {
		tier = 3,
		prog_tier = 4,
		icon_scalar = medium_icon_scale,
		get_sprite_set = ElectricMiningDrill.get_sprite_set,
		get_icon = ElectricMiningDrill.get_icon,
	},
	["nullius-large-miner-1"] = {
		tier = 2,
		prog_tier = 4,
		get_sprite_set = TallElectricMiningDrill.get_sprite_set,
		get_icon = TallElectricMiningDrill.get_area_icon,
		frame = "blue",
	},
	["nullius-large-miner-2"] = {
		tier = 3,
		prog_tier = 5,
		get_sprite_set = TallElectricMiningDrill.get_sprite_set,
		get_icon = TallElectricMiningDrill.get_area_icon,
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

	_lib.create_explosions_and_particles(entity.name, {
		base_entity_name = "electric-mining-drill",
		type = entity.type,
		tint = tint,
		particles = {
			["medium-long"] = 3,
		},
	})

	local corpse = _lib.create_remnant(entity.name, {
		base_entity_name = "electric-mining-drill",
		type = entity.type,
	})

	local sprite_set = options.get_sprite_set({
		tint = tint,
		frame = options.frame,
		animation_speed = entity.mining_speed,
	})

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local icon_data = options.get_icon({ tint = tint })
	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		icon_data = options.icon_scalar and _sprite_utils.icons.minify_icon(icon_data, options.icon_scalar) or icon_data,
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

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

		local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
			tier = tier,
			name = entity.name,
			type_name = entity.type,
			icon_data = _sprite_utils.icons.minify_icon(burner_icon, options.icon_scalar),
		})

		_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)
	end
end
