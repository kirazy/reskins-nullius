---@using data
---@using Reskins.Framework

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local ThermalExtractor = require("__reskins-assets-api__.assets.angels.entities.refining.thermal-extractor")

---Assigns the icon of the thermal extractor, in the given `tint` and with the tier label of the given `tier`, to the
---prototype with the given `name`.
---@param name string
---@param tier Tier
---@param tint Color
local function assign_icon(name, tier, tint)
	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "assembling-machine",
		composition = ThermalExtractor.get_icon_composition({ tint = tint }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)
end

local tier_map = {
	["nullius-compressor-1"] = { tier = 1, prog_tier = 1 },
	["nullius-compressor-2"] = { tier = 2, prog_tier = 2 },
	["nullius-compressor-3"] = { tier = 3, prog_tier = 3 },
}

local compressor_entities = {
	["nullius-surge-compressor-1"] = { tier = 1, prog_tier = 1, shade = 1.18 },
	["nullius-priority-compressor-1"] = { tier = 1, prog_tier = 1, shade = 0.82 },
	["nullius-surge-compressor-2"] = { tier = 2, prog_tier = 2, shade = 1.18 },
	["nullius-priority-compressor-2"] = { tier = 2, prog_tier = 2, shade = 0.82 },
	["nullius-surge-compressor-3"] = { tier = 3, prog_tier = 3, shade = 1.18 },
	["nullius-priority-compressor-3"] = { tier = 3, prog_tier = 3, shade = 0.82 },
}

local function get_component(color, key, index, fallback)
	return color[key] or color[index] or fallback
end

local function shade_tint(tint, shade)
	local r = get_component(tint, "r", 1, 1)
	local g = get_component(tint, "g", 2, 1)
	local b = get_component(tint, "b", 3, 1)
	local a = get_component(tint, "a", 4, 1)

	if shade > 1 then
		local amount = shade - 1
		return {
			r + ((1 - r) * amount),
			g + ((1 - g) * amount),
			b + ((1 - b) * amount),
			a,
		}
	end

	return {
		r * shade,
		g * shade,
		b * shade,
		a,
	}
end

local function tint_animation(animation, tint)
	if not animation then
		return
	end

	if animation.layers then
		for _, layer in pairs(animation.layers) do
			tint_animation(layer, tint)
		end

		return
	end

	if animation.filename and animation.filename:find("thermal-extractor-animation", 1, true) then
		animation.tint = tint
	end
end

for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)

	assign_icon(name, tier, _framework.tiers.get_tint(tier))
end

for name, map in pairs(compressor_entities) do
	local tier = _framework.tiers.get_tier(map)
	local tint = shade_tint(_framework.tiers.get_tint(tier), map.shade)

	local entity = data.raw["assembling-machine"][name]
	if not entity then
		goto continue
	end

	assign_icon(name, tier, tint)

	local animation = entity.graphics_set and entity.graphics_set.animation
	if animation then
		for _, direction in pairs({ "north", "east", "south", "west" }) do
			tint_animation(animation[direction], tint)
		end
	end

	::continue::
end
