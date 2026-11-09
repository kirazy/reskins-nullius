---@using data
---@using Reskins.Framework

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { icons = require("__reskins-assets-api__.api.icons") }
local _sprite_utils = {
	icons = require("__reskins-sprite-utils__.icons"),
	colors = require("__reskins-sprite-utils__.colors"),
}

local Applicators = require("__reskins-assets-api__.api.applicators")
local Beacon = require("__reskins-assets-api__.assets.base.entities.beacon")

local penalty_tints = {
	util.color("#ffe500"),
	util.color("#ff9900"),
	util.color("#ff4d00"),
	util.color("#ff0000"),
}

---@param base_entity BeaconPrototype
---@param base_tint Color
---@param tier Tier
---@param options table
local function update_penalty_variants(base_entity, base_tint, tier, options)
	for idx, weight in pairs(options.penalties) do
		local entity = data.raw["beacon"][base_entity.name .. "-" .. idx]
		if entity then
			local scaled_weight = 0.5 + 0.5 * weight
			local tint = _sprite_utils.colors.blend({ 0.2, 0.2, 0.2 }, base_tint, scaled_weight) --[[@as Color]]
			local sprite_set = Beacon.get_sprite_set({
				tint = tint,
				slot_count = base_entity.module_slots,
			})
			sprite_set.set.corpse = base_entity.corpse
			sprite_set.set.dying_explosion = base_entity.dying_explosion

			Applicators.apply_sprite_set(entity, sprite_set, { scale = options.scale })

			local icon = _sprite_utils.icons.minify_icon(Beacon.get_icon({ tint = tint }), options.icon_scalar)
			local penalty_indicator = _sprite_utils.icons.transform_icons(
				_sprite_utils.icons.float_icons(
					_assets.icons.get_tinted_icon(
						"__reskins-framework__/graphics/icons/tiers/chevron/" .. idx .. ".png",
						penalty_tints[idx]
					)
				),
				{ shift = { 25, 0 } }
			)

			local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
				tier = tier,
				name = entity.name,
				type_name = entity.type,
				icon_data = _sprite_utils.icons.compose_icons("default", icon, penalty_indicator),
				-- The penalty variant shares its corpse and explosion with the base beacon.
				options = {
					infer_explosion = false,
					infer_corpse = false,
				},
			})
			_sprite_utils.icons.apply_icon_assignment(icon_assignment)
		end
	end
end

local entities = {
	["nullius-beacon-1"] = {
		tier = 1,
		prog_tier = 1,
		icon_scalar = 0.8,
		scale = 0.4,
		penalties = { 0.45, 0.40, 0.30, 0.15 },
	},
	["nullius-beacon-2"] = {
		tier = 2,
		prog_tier = 2,
		icon_scalar = 0.8,
		scale = 0.45,
		penalties = { 0.36, 0.32, 0.24, 0.12 },
	},
	["nullius-beacon-3"] = {
		tier = 3,
		prog_tier = 3,
		icon_scalar = 0.8,
		scale = 0.5,
		penalties = { 0.45, 0.40, 0.30, 0.15 },
	},
	["nullius-large-beacon-1"] = { tier = 1, prog_tier = 2, tint_tier = 2, scale = 0.6 },
	["nullius-large-beacon-2"] = { tier = 2, prog_tier = 3, tint_tier = 3, scale = 0.665 },
}

for name, options in pairs(entities) do
	local entity = data.raw["beacon"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = Beacon.get_sprite_set({
		tint = tint,
		slot_count = entity.module_slots,
	})

	Applicators.apply_sprite_set(entity, sprite_set, { scale = options.scale })

	local composition = Beacon.get_icon_composition({ tint = tint })
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = entity.type,
		composition = options.icon_scalar and composition:minify(options.icon_scalar) or composition,
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	if options.penalties then
		update_penalty_variants(entity, tint, tier, options)
	end

	::continue::
end
