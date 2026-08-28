---@using data
---@using Reskins.Assets.Applicators

local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = { defines = require("__reskins-assets-api__.api.defines") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Pumpjack = require("__reskins-assets-api__.assets.base.entities.pumpjack")

local entities = {
	["nullius-well-1"] = {
		tier = 1,
		prog_tier = 2,
		base_tint = util.color("#47abcc") --[[@as Color]],
		accent_tint = util.color("#cc7052") --[[@as Color]],
	},
	["nullius-well-2"] = {
		tier = 2,
		prog_tier = 3,
		base_tint = util.color("#4c6fd9") --[[@as Color]],
		accent_tint = util.color("#ccad52") --[[@as Color]],
	},
}

for name, options in pairs(entities) do
	local entity = data.raw["assembling-machine"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(entity.name, {
		base_entity_name = "pumpjack",
		type = entity.type,
		tint = tint,
		particles = {
			["small"] = 3,
		},
	})

	local corpse = _lib.create_remnant(entity.name, {
		base_entity_name = "pumpjack",
		type = entity.type,
	})

	local sprite_set = Pumpjack.get_sprite_set({
		-- tint = tint,
		base_tint = options.base_tint,
		accent_tint = tint,
	})

	sprite_set.converters = {
		[_assets.defines.sprite_set_type.crafting_machine_sprite_set] = function(sprite_set)
			---@cast sprite_set MiningDrillSpriteSet
			---@type CraftingMachineSpriteSet
			local crafting_machine_sprite_set = {
				-- In general, a mining drill graphics set is not compatible due to the animation
				-- translating, but for pumpjacks which are simple, a straight passthrough will be useful.
				graphics_set = sprite_set.graphics_set --[[@as CraftingMachineGraphicsSet]],
				graphics_set_flipped = sprite_set.graphics_set_flipped --[[@as CraftingMachineGraphicsSet]],
				integration_patch = sprite_set.integration_patch,
				integration_patch_render_layer = sprite_set.integration_patch_render_layer,
				dying_explosion = sprite_set.dying_explosion,
				corpse = sprite_set.corpse,
				water_reflection = sprite_set.water_reflection,
				nominal_width = sprite_set.nominal_width,
				nominal_height = sprite_set.nominal_height,
			}

			return crafting_machine_sprite_set
		end,
	}

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		icon_data = _sprite_utils.icons.minify_icon(Pumpjack.get_icon(tint), 0.8),
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
