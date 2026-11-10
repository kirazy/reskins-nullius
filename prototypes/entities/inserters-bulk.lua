---@using data
---@using Reskins.SpriteUtils

local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local Applicators = require("__reskins-assets-api__.api.applicators")
local Inserter = require("__reskins-assets-api__.assets.base.entities.inserter")

local entities = {
	["bulk-inserter"] = {
		type = "inserter",
		tint = util.color("#45bcec"),
	},
	["bob-express-bulk-inserter"] = {
		type = "inserter",
		tint = util.color("#9fd942"),
	},
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local sprite_set = Inserter.get_sprite_set({
		tint = options.tint,
		variant = "inserter-bulk",
	})

	Applicators.apply_sprite_set(entity, sprite_set)

	---@type IconAssignment
	local icon_assignment = {
		name = name,
		type_name = options.type,
		composition = Inserter.get_bulk_icon_composition({ tint = options.tint }),
	}

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
