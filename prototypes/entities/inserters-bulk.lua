local _lib = require("_lib")
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local icon_helpers = require("__reskins-assets-api__.api.icon-helpers")

local InserterGraphicsPack = require("__reskins-assets-api__.graphics-packs.base.inserter-graphics-pack")
local bulk_inserter_icon_creator_fn = icon_helpers.make_tinted_three_layer_icon_creator_fn({
	folder = "__reskins-assets-bobs__/graphics/icons/inserters/",
	icon_name = "inserter-bulk",
})

local entities = {
	["bulk-inserter"] = {
		type = "inserter",
		tint = util.color("#45bcec"),
		icon_creator_fn = bulk_inserter_icon_creator_fn,
	},
	["bob-express-bulk-inserter"] = {
		type = "inserter",
		tint = util.color("#9fd942"),
		icon_creator_fn = bulk_inserter_icon_creator_fn,
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

	local graphics_pack = InserterGraphicsPack:configure({
		tint = options.tint,
		variant = "inserter-bulk",
	})

	graphics_pack:apply_to_entity(entity)
	graphics_pack:apply_to_corpse(corpse)

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = options.icon_creator_fn(options.tint),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
