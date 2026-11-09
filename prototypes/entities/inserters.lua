---@using Reskins.SpriteUtils

local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local InserterPreset = require("__reskins-assets-api__.assets.base.entities.inserter-preset")

local entities = {
	["inserter"] = {
		type = "inserter",
		preset = "inserter",
	},
	["bob-turbo-inserter"] = {
		type = "inserter",
		preset = "inserter-filter",
	},
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local sprite_set = InserterPreset.get_sprite_set({
		preset = options.preset,
		is_long = true,
	})

	Applicators.apply_sprite_set(entity, sprite_set)

	---@type IconAssignment
	local icon_assignment = {
		name = name,
		type_name = options.type,
		icon_data = InserterPreset.get_icon(options.preset),
	}

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
