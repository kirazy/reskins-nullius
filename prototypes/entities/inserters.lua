local _lib = require("_lib")
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local icon_helpers = require("__reskins-assets-api__.api.icon-helpers")

local InserterPresetGraphicsPack = require("__reskins-assets-api__.graphics-packs.base.inserter-preset-graphics-pack")
local inserter_icon_creator_fn = icon_helpers.make_flat_icon_creator_fn({
	folder = "__reskins-assets-bobs__/graphics/icons/inserters",
	icon_name = "filter-inserter-icon",
})

local entities = {
	["bob-turbo-inserter"] = {
		type = "inserter",
		icon_data = inserter_icon_creator_fn(),
		tint = util.color("#a26ae3"),
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
		tint = options.tint,
		particles = {
			["medium"] = 1,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "inserter",
		type = options.type,
	})

	local graphics_pack = InserterPresetGraphicsPack:configure({
		preset = options.preset,
	})

	graphics_pack:apply_to_entity(entity)
	graphics_pack:apply_to_corpse(corpse)

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = options.icon_data,
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
