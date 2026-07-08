local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _lib = require("_lib")

---@type LibHack.ConstructIconInputsOld
local inputs = {
	type = "assembling-machine",
	icon_name = "thermal-extractor",
	graphics_mod = "assets-angels",
}

---@diagnostic disable-next-line: param-type-mismatch
_lib.set_inputs_defaults(inputs)

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

	if animation.filename
		and animation.filename:find("thermal-extractor-animation", 1, true)
	then
		animation.tint = tint
	end
end

for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)
	inputs.tint = _framework.tiers.get_tint(tier)

	_lib.construct_icon(name, tier, inputs)
end

for name, map in pairs(compressor_entities) do
	local tier = _framework.tiers.get_tier(map)
	local tint = shade_tint(_framework.tiers.get_tint(tier), map.shade)

	---@type data.AssemblingMachinePrototype
	local entity = data.raw["assembling-machine"]
		and data.raw["assembling-machine"][name]

	if not entity then
		goto continue
	end

	inputs.tint = tint
	_lib.construct_icon(name, tier, inputs)

	local animation = entity.graphics_set and entity.graphics_set.animation
	if animation then
		for _, direction in pairs({ "north", "east", "south", "west" }) do
			tint_animation(animation[direction], tint)
		end
	end

	::continue::
end
