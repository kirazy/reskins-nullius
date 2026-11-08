---@using data

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
}
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local SteamTurbine = require("__reskins-assets-api__.assets.base.entities.steam-turbine")

-- A turbine is a furnace that draws the idle turbine, and a generator of the same size that draws the turbine when it
-- generates power.
local closures = { "open", "closed" }
local modes = { "standard", "exhaust", "backup" }

---Gets the vertical and horizontal animations of the steam turbine in the given `tint`.
---
---The animations are at the size of the steam turbine and are not rescaled.
---@param tint Color
---@return Animation vertical
---@return Animation horizontal
local function get_animations(tint)
	local sprite_set = SteamTurbine.get_sprite_set({ tint = tint })
	local vertical = util.copy(sprite_set.set.pictures.north.animation) --[[@as Animation]]
	local horizontal = util.copy(sprite_set.set.pictures.east.animation) --[[@as Animation]]

	return vertical, horizontal
end

---Gets a copy of the given `animation` that shows its first frame only.
---@param animation Animation
---@return Animation
local function get_first_frame(animation)
	local frame = util.copy(animation)

	for _, layer in pairs(frame.layers) do
		layer.frame_count = 1
		layer.line_length = 1
		layer.repeat_count = nil
		layer.run_mode = nil
	end

	return frame
end

---Gets a copy of the given `animation` without its shadow layers.
---@param animation Animation
---@return Animation
local function get_without_shadows(animation)
	local layers = {}

	for _, layer in pairs(animation.layers) do
		if not layer.draw_as_shadow then
			layers[#layers + 1] = util.copy(layer)
		end
	end

	return { layers = layers }
end

---Inserts a copy of the given `overlay` layer above the base layer of the given `animation`, in place.
---@param animation Animation
---@param overlay? Animation
local function insert_overlay(animation, overlay)
	if overlay then
		table.insert(animation.layers, 2, util.copy(overlay))
	end
end

---Defines the layers that mark the mode of a turbine.
---@class TurbineOverlays
---The overlay of the furnace when it faces north or south.
---@field vertical? Animation
---The overlay of the furnace when it faces east or west.
---@field horizontal? Animation
---The overlay of the generator when it faces north or south.
---@field generator_vertical? Animation
---The overlay of the generator when it faces east or west.
---@field generator_horizontal? Animation

---Gets copies of the overlays from the open turbine in the third tier for the given `mode`.
---@param mode string
---@return TurbineOverlays
local function get_overlays(mode)
	local furnace = data.raw["furnace"]["nullius-turbine-open-" .. mode .. "-3"]
	local generator = data.raw["generator"]["nullius-turbine-generator-open-" .. mode .. "-3"]

	---@type TurbineOverlays
	local overlays = {}

	if furnace then
		overlays.vertical = util.copy(furnace.graphics_set.idle_animation.north.layers[2])
		overlays.horizontal = util.copy(furnace.graphics_set.idle_animation.east.layers[2])
	end

	if generator then
		overlays.generator_vertical = util.copy(generator.vertical_animation.layers[2])
		overlays.generator_horizontal = util.copy(generator.horizontal_animation.layers[2])
	end

	return overlays
end

-- Every turbine uses the overlays from the open turbine in the third tier, and the standard turbines have none.
---@type table<string, TurbineOverlays>
local overlays_by_mode = {}
for _, mode in pairs(modes) do
	overlays_by_mode[mode] = mode == "standard" and {} or get_overlays(mode)
end

for _, closure in pairs(closures) do
	for _, mode in pairs(modes) do
		local overlays = overlays_by_mode[mode]

		for tier = 1, 3 do
			local suffix = closure .. "-" .. mode .. "-" .. tier
			local tint = _framework.tiers.get_tint(tier)

			local furnace = data.raw["furnace"]["nullius-turbine-" .. suffix]
			if furnace then
				local vertical, horizontal = get_animations(tint)

				vertical = get_first_frame(vertical)
				horizontal = get_first_frame(horizontal)
				insert_overlay(vertical, overlays.vertical)
				insert_overlay(horizontal, overlays.horizontal)

				furnace.graphics_set = furnace.graphics_set or {}
				furnace.graphics_set.idle_animation = {
					north = vertical,
					east = horizontal,
					south = util.copy(vertical),
					west = util.copy(horizontal),
				}
			end

			local generator = data.raw["generator"]["nullius-turbine-generator-" .. suffix]
			if generator then
				local vertical, horizontal = get_animations(tint)

				-- The furnace draws the shadow.
				vertical = get_without_shadows(vertical)
				horizontal = get_without_shadows(horizontal)
				insert_overlay(vertical, overlays.generator_vertical)
				insert_overlay(horizontal, overlays.generator_horizontal)

				generator.vertical_animation = vertical
				generator.horizontal_animation = horizontal
			end
		end
	end
end

local tier_map = {
	["nullius-turbine-open-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-open-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-open-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-open-standard-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-open-standard-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-open-standard-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-open-exhaust-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-open-exhaust-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-open-exhaust-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-open-backup-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-open-backup-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-open-backup-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-closed-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-closed-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-closed-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-closed-standard-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-closed-standard-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-closed-standard-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-closed-exhaust-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-closed-exhaust-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-closed-exhaust-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-closed-backup-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-closed-backup-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-closed-backup-3"] = { tier = 3, prog_tier = 3 },
}

for name, options in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)
	local symbol = name:find("open") and _assets.defines.symbol.aperture_open or _assets.defines.symbol.aperture_closed

	local composition = SteamTurbine.get_icon_composition({ tint = tint })
		:add_symbol(_assets.icons.get_symbol(symbol, tint))

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "furnace",
		composition = composition,
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)
end
