local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { icons = require("__reskins-assets-api__.api.icons") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local FurnaceStone = require("__reskins-assets-api__.assets.base.entities.furnace-stone")
local FurnaceSteel = require("__reskins-assets-api__.assets.base.entities.furnace-steel")
local FurnaceElectric = require("__reskins-assets-api__.assets.base.entities.furnace-electric")

local small_icon_scale = 0.8
local medium_icon_scale = 0.9

local entities = {
	["nullius-small-furnace-1"] = {
		tier = 1,
		prog_tier = 0,
		module = FurnaceStone,
		variant = "standard",
		icon_scalar = small_icon_scale,
		letter = "S",
	},
	["nullius-small-furnace-2"] = {
		tier = 2,
		prog_tier = 1,
		module = FurnaceSteel,
		variant = "standard",
		icon_scalar = small_icon_scale,
		letter = "S",
	},
	["nullius-small-furnace-3"] = {
		tier = 3,
		prog_tier = 2,
		module = FurnaceElectric,
		variant = "standard",
		icon_scalar = small_icon_scale,
		letter = "S",
	},
	["nullius-medium-furnace-1"] = {
		tier = 1,
		prog_tier = 1,
		module = FurnaceSteel,
		variant = "standard",
		icon_scalar = medium_icon_scale,
		letter = "M",
	},
	["nullius-medium-furnace-2"] = {
		tier = 2,
		prog_tier = 2,
		module = FurnaceElectric,
		variant = "standard",
		icon_scalar = medium_icon_scale,
		letter = "M",
	},
	["nullius-medium-furnace-3"] = {
		tier = 3,
		prog_tier = 3,
		module = FurnaceElectric,
		variant = "standard",
		icon_scalar = medium_icon_scale,
		letter = "M",
	},
	["nullius-large-furnace-1"] = {
		tier = 1,
		prog_tier = 2,
		module = FurnaceElectric,
		variant = "mixing",
		letter = "L",
	},
	["nullius-large-furnace-2"] = {
		tier = 2,
		prog_tier = 3,
		module = FurnaceElectric,
		variant = "mixing",
		letter = "L",
	},
}

for name, options in pairs(entities) do
	local entity = data.raw["assembling-machine"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = options.module.get_sprite_set({
		tint = tint,
		variant = options.variant,
	})

	-- Strip pipe pictures until bespoke sprites tailored for Nullius can be prepared.
	sprite_set.set.fluid_boxes = nil

	-- Furnace animations aren't designed with variable speed in mind; slow-moving flames look horrible.
	entity.match_animation_speed_to_activity = options.module == FurnaceElectric

	Applicators.apply_sprite_set(entity, sprite_set)

	local composition = options.module
		.get_icon_composition({ tint = tint, variant = options.variant })
		:add_label(_assets.icons.get_letter(options.letter, tint))
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		composition = options.icon_scalar and composition:minify(options.icon_scalar) or composition,
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
