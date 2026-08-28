---@using Reskins.SpriteUtils

local _lib = require("_lib")
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local InserterPreset = require("__reskins-assets-api__.assets.base.entities.inserter-preset")

local entities = {
	["inserter"] = {
		type = "inserter",
		particle_tint = util.color("#ffaa23"),
		preset = "inserter",
	},
	["bob-turbo-inserter"] = {
		type = "inserter",
		particle_tint = util.color("#a26ae3"),
		preset = "inserter-filter",
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
		tint = options.particle_tint,
		particles = {
			["medium"] = 1,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "inserter",
		type = options.type,
	})

	local sprite_set = InserterPreset.get_sprite_set({
		preset = options.preset,
		is_long = true,
	})

	Applicators.apply_sprite_set(entity, sprite_set)
	Applicators.apply_sprite_set(corpse, sprite_set)

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = InserterPreset.get_icon(options.preset),
	}

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
