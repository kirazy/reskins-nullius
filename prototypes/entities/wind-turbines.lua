---@using data
---@using Reskins.Assets

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local PrototypeScaler = require("__reskins-assets-api__.api.prototype-scaler")
local WindTurbine = require("__reskins-assets-api__.assets.assorted.entities.wind-turbine")

-- A wind turbine is placed as an entity that the script of Nullius replaces with the base of the tower. The script
-- draws the rotor and its shadow on the base with one animation for each of the eight wind orientations.

-- The orientation of the rotor that the script draws on a wind turbine when a game begins.
local INITIAL_ROTOR_ORIENTATION = 5

-- The number of frames the script counts for one third of a revolution. The script keeps the rotor continuous through a
-- change of wind speed with an animation offset in these frames, so each animation has exactly this many.
local SCRIPT_FRAME_COUNT = 24

---Moves each layer in the given `animation` by the given offset in tiles, in place.
---@param animation Animation
---@param x double
---@param y double
local function prepare_script_animation(animation, x, y)
	assert(animation.layers)
	for _, layer in pairs(animation.layers) do
		assert(layer.frame_count == SCRIPT_FRAME_COUNT)
		assert(layer.shift and layer.shift[1] and layer.shift[2])
		layer.shift = { layer.shift[1] + x, layer.shift[2] + y }
	end
end

for tier = 1, 3 do
	local base = data.raw["electric-energy-interface"]["nullius-wind-base-" .. tier]
	if not base then
		goto continue
	end

	local label_tier = _framework.tiers.get_tier({ tier = tier, prog_tier = tier })
	local tint = _framework.tiers.get_tint(label_tier)

	-- Nullius draws its artwork at this scale, and the script places the rotor and its shadow at distances from the
	-- entity that are multiples of it. The artwork of the sprite set is 1.2 times the size of the artwork of Nullius.
	local nullius_scale = 0.4 + 0.2 * tier
	local scale = nullius_scale / 1.2

	Applicators.apply_sprite_set(base, WindTurbine.get_sprite_set({ tint = tint }), { scale = scale })

	local build = data.raw["electric-energy-interface"]["nullius-wind-build-" .. tier]
	if build then
		local sprite_set = WindTurbine.get_sprite_set({ tint = tint, rotor_orientation = INITIAL_ROTOR_ORIENTATION })
		Applicators.apply_sprite_set(build, sprite_set, { scale = scale })
	end

	local scaler = PrototypeScaler.for_prototype(base, { scale = scale })
	local animations = {}

	for orientation = 1, 8 do
		local suffix = tier .. "-" .. (orientation - 1)

		-- The script draws the rotor 10 tiles above the entity.
		local rotor = WindTurbine.get_rotor_animation({ orientation = orientation, tint = tint })
		scaler:rescale(rotor)
		prepare_script_animation(rotor, 0, 10 * nullius_scale)

		-- The script draws the shadow 6 tiles to the right of the entity and 1 tile above it.
		local shadow = WindTurbine.get_rotor_shadow_animation({ orientation = orientation })
		scaler:rescale(shadow)
		prepare_script_animation(shadow, -6 * nullius_scale, nullius_scale)

		animations[#animations + 1] = {
			type = "animation",
			name = "nullius-wind-blade-" .. suffix,
			layers = rotor.layers,
		}
		animations[#animations + 1] = {
			type = "animation",
			name = "nullius-wind-shadow-" .. suffix,
			layers = shadow.layers,
		}
	end

	data:extend(animations)

	local targets = {
		{ name = "nullius-wind-turbine-" .. tier, type_name = "item" },
		{ name = "nullius-wind-base-" .. tier, type_name = "electric-energy-interface" },
		{ name = "nullius-wind-build-" .. tier, type_name = "electric-energy-interface" },
	}

	for _, target in pairs(targets) do
		local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
			tier = label_tier,
			name = target.name,
			type_name = target.type_name,
			composition = WindTurbine.get_icon_composition({ tint = tint }),
		})
		_sprite_utils.icons.apply_icon_assignment(icon_assignment)
	end

	::continue::
end
