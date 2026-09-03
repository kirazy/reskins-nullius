---@using data
---@using Reskins.SpriteUtils

local _lib = require("_lib")
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Inserter = require("__reskins-assets-api__.assets.base.entities.inserter")

local entities = {
	["bulk-inserter"] = {
		type = "inserter",
		tint = util.color("#45bcec") --[[@as Color]],
	},
	["bob-express-bulk-inserter"] = {
		type = "inserter",
		tint = util.color("#9fd942") --[[@as Color]],
	},
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "inserter",
		type = options.type,
		tint = options.tint,
		particles = {
			["medium"] = 1,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "inserter",
		type = options.type,
	})

	local sprite_set = Inserter.get_sprite_set({
		tint = options.tint,
		variant = "inserter-bulk",
	})

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = Inserter.get_bulk_icon({ tint = options.tint }),
	}

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
