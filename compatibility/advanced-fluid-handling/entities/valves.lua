if not mods["underground-pipe-pack"] then
	return
end

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local PipeValve = require("__reskins-assets-api__.assets.angels.entities.petrochem.pipe-valve")

local valves = {
	["check-valve"] = {
		tint = util.color("#8dd24e"),
	},
	["overflow-valve"] = {
		tint = util.color("#d4933f"),
		has_increments = true,
	},
	["top-up-valve"] = {
		tint = util.color("#fcfcfc"),
		has_increments = true,
	},
}

local increments = { "10", "20", "30", "40", "50", "60", "70", "80", "90" }

-- The arrow of an Underground Pipe Pack valve points the way the valve faces, and the arrow of the Angel's valve
-- artwork points the other way, so each direction uses the artwork of the opposite direction.
local artwork_directions = {
	north = "south",
	east = "west",
	south = "north",
	west = "east",
}

-- Each entry is the shift of the increment label for the direction of the artwork over which the label is drawn.
local increment_shifts = {
	north = util.by_pixel(0, -16.5),
	east = util.by_pixel(4, -11.5),
	south = util.by_pixel(0, -6),
	west = util.by_pixel(-4, -11.5),
}

---Gets the label of the given `increment` in the given `tint`, placed over the artwork for the given `direction`.
---@param increment string
---@param tint Color
---@param direction "north"|"east"|"south"|"west"
---@return Sprite
local function get_increment_layer(increment, tint, direction)
	return {
		filename = "__underground-pipe-pack__/graphics/entity/valves/top-up/" .. increment .. ".png",
		priority = "extra-high",
		width = 38,
		height = 28,
		tint = tint,
		scale = 0.4,
		shift = increment_shifts[direction],
	}
end

---Reskins the valve with the given `name` in the given `tint`, with the label of the given `increment`, if any.
---@param name string
---@param tint Color
---@param increment? string
local function handle_valve_variant(name, tint, increment)
	local entity = data.raw["valve"][name]
	if not entity then
		return
	end

	local sprite_set = PipeValve.get_sprite_set({ tint = tint })
	local artwork = util.copy(sprite_set.set.animations)

	local animations = {}
	for direction, artwork_direction in pairs(artwork_directions) do
		local animation = artwork[artwork_direction]
		if increment then
			animation.layers[#animation.layers + 1] = get_increment_layer(increment, tint, artwork_direction)
		end

		animations[direction] = animation
	end

	entity.animations = animations

	Applicators.apply_corpse_and_explosion(entity, {
		corpse = sprite_set.set.corpse,
		dying_explosion = sprite_set.set.dying_explosion,
	})

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = 0,
		name = entity.name,
		type_name = entity.type,
		composition = PipeValve.get_icon_composition({ tint = tint }),
	})
	_sprite_utils.icons.apply_icon_assignment(icon_assignment)
end

for valve, options in pairs(valves) do
	if options.has_increments then
		for _, increment in pairs(increments) do
			handle_valve_variant(increment .. "-" .. valve, options.tint, increment)
		end
	else
		handle_valve_variant(valve, options.tint)
	end
end
