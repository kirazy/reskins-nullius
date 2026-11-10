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

---Inserts a copy of the given `overlay` layer above the base layer of the given `animation`, in place, and sets the
---copy to repeat for each frame of the base layer.
---@param animation Animation
---@param overlay? Animation
local function insert_overlay(animation, overlay)
	if overlay then
		local layer = util.copy(overlay)
		layer.repeat_count = animation.layers[1].frame_count

		table.insert(animation.layers, 2, layer)
	end
end

---Defines the layers that mark the mode of a turbine.
---@class TurbineOverlays
---The overlay of the turbine when it faces north or south.
---@field vertical? Animation
---The overlay of the turbine when it faces east or west.
---@field horizontal? Animation

---Gets copies of the overlays from the open turbine in the third tier for the given `mode`.
---@param mode string
---@return TurbineOverlays
local function get_overlays(mode)
	local furnace = data.raw["furnace"]["nullius-turbine-open-" .. mode .. "-3"]

	---@type TurbineOverlays
	local overlays = {}

	if furnace then
		overlays.vertical = util.copy(furnace.graphics_set.idle_animation.north.layers[2])
		overlays.horizontal = util.copy(furnace.graphics_set.idle_animation.east.layers[2])
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

			-- The turbines are drawn at the size of the steam turbine and are not rescaled.
			local sprite_set = SteamTurbine.get_sprite_set({ tint = tint })

			local furnace = data.raw["furnace"]["nullius-turbine-" .. suffix]
			if furnace then
				local vertical = get_first_frame(sprite_set.set.pictures.north.animation --[[@as Animation]])
				local horizontal = get_first_frame(sprite_set.set.pictures.east.animation --[[@as Animation]])

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
				local pictures = util.copy(sprite_set.set.pictures)

				insert_overlay(pictures.north.animation --[[@as Animation]], overlays.vertical)
				insert_overlay(pictures.east.animation --[[@as Animation]], overlays.horizontal)

				generator.two_direction_only = sprite_set.set.two_direction_only
				generator.pictures = pictures
			end
		end
	end
end

local TIER_ONE = { tier = 1, prog_tier = 1 }
local TIER_TWO = { tier = 2, prog_tier = 2 }
local TIER_THREE = { tier = 3, prog_tier = 3 }

local tier_map = {
	["nullius-turbine-open-1"] = TIER_ONE,
	["nullius-turbine-open-2"] = TIER_TWO,
	["nullius-turbine-open-3"] = TIER_THREE,
	["nullius-turbine-open-standard-1"] = TIER_ONE,
	["nullius-turbine-open-standard-2"] = TIER_TWO,
	["nullius-turbine-open-standard-3"] = TIER_THREE,
	["nullius-turbine-open-exhaust-1"] = TIER_ONE,
	["nullius-turbine-open-exhaust-2"] = TIER_TWO,
	["nullius-turbine-open-exhaust-3"] = TIER_THREE,
	["nullius-turbine-open-backup-1"] = TIER_ONE,
	["nullius-turbine-open-backup-2"] = TIER_TWO,
	["nullius-turbine-open-backup-3"] = TIER_THREE,
	["nullius-turbine-closed-1"] = TIER_ONE,
	["nullius-turbine-closed-2"] = TIER_TWO,
	["nullius-turbine-closed-3"] = TIER_THREE,
	["nullius-turbine-closed-standard-1"] = TIER_ONE,
	["nullius-turbine-closed-standard-2"] = TIER_TWO,
	["nullius-turbine-closed-standard-3"] = TIER_THREE,
	["nullius-turbine-closed-exhaust-1"] = TIER_ONE,
	["nullius-turbine-closed-exhaust-2"] = TIER_TWO,
	["nullius-turbine-closed-exhaust-3"] = TIER_THREE,
	["nullius-turbine-closed-backup-1"] = TIER_ONE,
	["nullius-turbine-closed-backup-2"] = TIER_TWO,
	["nullius-turbine-closed-backup-3"] = TIER_THREE,
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
