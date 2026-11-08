---@using data

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local PrototypeScaler = require("__reskins-assets-api__.api.prototype-scaler")
local RoboZoneExpander = require("__reskins-assets-api__.assets.bobs.entities.robo-zone-expander")

-- The relays draw the logistic zone expander at 0.6 times its size. The relays keep their own recharging and
-- stationing fields.
local SCALE_FACTOR = 0.6

local entities = {
	["nullius-relay-1"] = { tier = 1, prog_tier = 2, image_index = 1 },
	["nullius-relay-2"] = { tier = 2, prog_tier = 3, image_index = 2 },
	["nullius-relay-3"] = { tier = 3, prog_tier = 4, image_index = 3 },
	["nullius-relay-4"] = { tier = 4, prog_tier = 5, image_index = 4 },
	["nullius-relay-construction-1"] = {
		tier = 1,
		prog_tier = 2,
		image_index = 1,
		antenna_image_index = 4,
		antenna_tint = { 0.9, 0.8, 0.7 },
	},
	["nullius-relay-construction-2"] = {
		tier = 2,
		prog_tier = 3,
		image_index = 2,
		antenna_image_index = 3,
		antenna_tint = { 0.85, 1, 0.9 },
	},
	["nullius-relay-construction-3"] = {
		tier = 3,
		prog_tier = 4,
		image_index = 3,
		antenna_image_index = 3,
		antenna_tint = { 1, 1, 0.75 },
	},
	["nullius-relay-construction-4"] = {
		tier = 4,
		prog_tier = 5,
		image_index = 4,
		antenna_image_index = 1,
		antenna_tint = { 0.7, 0.7, 0.7 },
	},
}

for name, options in pairs(entities) do
	local entity = data.raw["roboport"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = RoboZoneExpander.get_sprite_set({ tint = tint, tier = options.image_index })
	local graphics_set = util.copy(sprite_set.set.graphics_set)
	local water_reflection = util.copy(sprite_set.set.water_reflection)

	-- The construction relays draw the antenna of another tier, in their own tint.
	if options.antenna_image_index then
		local antenna_set = RoboZoneExpander.get_sprite_set({ tier = options.antenna_image_index })
		local antenna = util.copy(antenna_set.set.graphics_set.base_animation.layers[1])
		antenna.tint = options.antenna_tint
		graphics_set.base_animation.layers[1] = antenna
	end

	local scaler = PrototypeScaler.for_prototype(entity, { scale_factor = SCALE_FACTOR })
	scaler:rescale(graphics_set)
	scaler:rescale(water_reflection)

	entity.base = graphics_set.base
	entity.base_animation = graphics_set.base_animation
	entity.base_patch = graphics_set.base_patch
	entity.door_animation_up = graphics_set.door_animation_up
	entity.door_animation_down = graphics_set.door_animation_down
	entity.water_reflection = water_reflection

	Applicators.apply_corpse_and_explosion(entity, {
		corpse = sprite_set.set.corpse,
		dying_explosion = sprite_set.set.dying_explosion,
	})

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		composition = RoboZoneExpander.get_icon_composition({ tint = tint, tier = options.image_index }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
