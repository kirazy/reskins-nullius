local _lib = require("_lib")
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local InserterPresetGraphicsPack = require("__reskins-assets-api__.graphics-packs.base.inserter-preset-graphics-pack")

local entities = {
	["inserter"] = {
		type = "inserter",
		icon_filename = "__reskins-assets-bobs__/graphics/icons/inserters/inserter-icon.png",
		particle_tint = util.color("#ffaa23"),
		preset = "inserter",
	},
	["bob-turbo-inserter"] = {
		type = "inserter",
		icon_filename = "__reskins-assets-bobs__/graphics/icons/inserters/filter-inserter-icon.png",
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

	local graphics_pack = InserterPresetGraphicsPack:configure({
		preset = options.preset,
		is_long = true,
	})

	graphics_pack:apply_to_entity(entity)
	graphics_pack:apply_to_corpse(corpse)

	---@type DeferrableIconDatum
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_datum = {
			icon = options.icon_filename,
			icon_size = 64,
		},
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
