---@using data

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local PrototypeScaler = require("__reskins-assets-api__.api.prototype-scaler")
local SteamEngine = require("__reskins-assets-api__.assets.base.entities.steam-engine")

-- A Stirling engine is an electric energy interface that shows a still picture. The engine draws the animations named
-- `nullius-stirling-vertical-turbine-<tier>` and `nullius-stirling-horizontal-turbine-<tier>` over the picture while it
-- runs.
local entities = {
	["nullius-stirling-engine-1"] = { tier = 1, prog_tier = 1 },
	["nullius-stirling-engine-2"] = { tier = 2, prog_tier = 2 },
	["nullius-stirling-engine-3"] = { tier = 3, prog_tier = 3 },
}

-- The engine is drawn at a scale of 0.475.
local SCALE = 0.475

---Gets a copy of the given `animation` that shows its first frame only, without its shadow layers.
---@param animation Animation
---@return Sprite
local function get_picture(animation)
	local layers = {}

	for _, layer in pairs(animation.layers or {}) do
		if not layer.draw_as_shadow then
			local picture_layer = util.copy(layer)
			picture_layer.frame_count = nil
			picture_layer.line_length = nil
			picture_layer.repeat_count = nil
			picture_layer.run_mode = nil
			layers[#layers + 1] = picture_layer
		end
	end

	return { layers = layers }
end

---Sets the layers of the animation prototype with the given `name` to the layers of the given `animation`, followed by
---the layers of the animation prototype that draw no steam engine artwork, in place.
---@param name string
---@param animation Animation
local function set_animation_layers(name, animation)
	local prototype = data.raw["animation"][name]
	if not prototype then
		return
	end

	local layers = util.copy(animation.layers)

	for _, layer in pairs(prototype.layers or {}) do
		if not (layer.filename and layer.filename:find("/steam-engine/", 1, true)) then
			layers[#layers + 1] = layer
		end
	end

	prototype.layers = layers
end

for name, options in pairs(entities) do
	local entity = data.raw["electric-energy-interface"][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local sprite_set = SteamEngine.get_sprite_set({ tint = tint })
	local vertical = util.copy(sprite_set.set.pictures.north.animation) --[[@as Animation]]
	local horizontal = util.copy(sprite_set.set.pictures.east.animation) --[[@as Animation]]
	local corpse = util.copy(sprite_set.set.corpse)

	local scaler = PrototypeScaler.for_prototype(entity, { scale = SCALE })
	scaler:rescale(vertical)
	scaler:rescale(horizontal)
	scaler:rescale(corpse)

	local vertical_picture = get_picture(vertical)
	local horizontal_picture = get_picture(horizontal)

	entity.pictures = {
		north = vertical_picture,
		east = horizontal_picture,
		south = util.copy(vertical_picture),
		west = util.copy(horizontal_picture),
	}

	set_animation_layers("nullius-stirling-vertical-turbine-" .. options.tier, vertical)
	set_animation_layers("nullius-stirling-horizontal-turbine-" .. options.tier, horizontal)

	Applicators.apply_corpse_and_explosion(entity, {
		corpse = corpse,
		dying_explosion = sprite_set.set.dying_explosion,
	})

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = entity.name,
		type_name = entity.type,
		composition = SteamEngine.get_icon_composition({ tint = tint }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
