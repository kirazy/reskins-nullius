---@using data
---@using Reskins.Assets
---@using Reskins.Assets.Applicators

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local PrototypeScaler = require("__reskins-assets-api__.api.prototype-scaler")
local ChemicalFurnace = require("__reskins-assets-api__.assets.angels.entities.smelting.chemical-furnace")

-- A geothermal plant is placed as a mining drill that builds the plant, and works as a reactor.
local tiers = {
	[1] = { tier = 1, prog_tier = 1 },
	[2] = { tier = 2, prog_tier = 2 },
	[3] = { tier = 3, prog_tier = 3 },
}

---Gets a copy of the animation from the given `sprite_set`, scaled for the given `entity`.
---@param entity MiningDrillPrototype|ReactorPrototype
---@param sprite_set SpriteSetDefinition<CraftingMachineSpriteSet>
---@return Animation
local function get_animation(entity, sprite_set)
	local animation = util.copy(sprite_set.set.graphics_set.animation) --[[@as Animation]]

	local scaler = PrototypeScaler.for_prototype(entity, {
		nominal_width = sprite_set.set.nominal_width,
		nominal_height = sprite_set.set.nominal_height,
	})
	scaler:rescale(animation)

	return animation
end

for building_tier, options in pairs(tiers) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = ChemicalFurnace.get_sprite_set({ tint = tint })
	local corpse_and_explosion = {
		corpse = sprite_set.set.corpse,
		dying_explosion = sprite_set.set.dying_explosion,
	}

	local build = data.raw["mining-drill"]["nullius-geothermal-build-" .. building_tier]
	if build then
		build.graphics_set = build.graphics_set or {}
		build.graphics_set.animation = get_animation(build, sprite_set)

		Applicators.apply_corpse_and_explosion(build, corpse_and_explosion)
	end

	local reactor = data.raw["reactor"]["nullius-geothermal-reactor-" .. building_tier]
	if reactor then
		reactor.working_light_picture = get_animation(reactor, sprite_set)

		Applicators.apply_corpse_and_explosion(reactor, corpse_and_explosion)
	end

	local names = {
		{ name = "nullius-geothermal-build-" .. building_tier, type_name = "mining-drill" },
		{ name = "nullius-geothermal-reactor-" .. building_tier, type_name = "reactor" },
		{ name = "nullius-geothermal-plant-" .. building_tier, type_name = "mining-drill" },
	}

	for _, target in pairs(names) do
		local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
			tier = tier,
			name = target.name,
			type_name = target.type_name,
			composition = ChemicalFurnace.get_icon_composition({ tint = tint }),
		})
		_sprite_utils.icons.apply_icon_assignment(icon_assignment)
	end
end
