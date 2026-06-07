local _lib = require("_lib")
local _sprites = require("__reskins-sprite-utils__.sprites")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local icon_helpers = require("__reskins-assets-api__.api.icon-helpers")

local standard_icon = icon_helpers.make_tinted_three_layer_icon_creator_fn({
	folder = "__reskins-assets-base__/graphics/icons",
	icon_name = "assembling-machine",
})

local function standard_gear(machine_tier)
	return {
		icon = "__reskins-assets-base__/graphics/icons/assembling-machine/gear-" .. (machine_tier - 1) .. ".png",
		icon_size = 64,
	}
end

local mini_icon = icon_helpers.make_tinted_three_layer_icon_creator_fn({
	folder = "__reskins-assets-assorted__/graphics/icons",
	icon_name = "mini-assembling-machine",
})

local function mini_gear(machine_tier)
	return {
		icon = "__reskins-assets-assorted__/graphics/icons/mini-assembling-machine/gear-mini-"
			.. (machine_tier - 1)
			.. ".png",
		icon_size = 64,
	}
end

local medium_icon = icon_helpers.make_tinted_three_layer_icon_creator_fn({
	folder = "__reskins-assets-assorted__/graphics/icons",
	icon_name = "medium-assembling-machine",
})

local function medium_gear(machine_tier)
	return {
		icon = "__reskins-assets-assorted__/graphics/icons/medium-assembling-machine/gear-medium-"
			.. (machine_tier - 1)
			.. ".png",
		icon_size = 64,
	}
end

local function resolve_icon(tint, machine_tier, scale_factor)
	if not scale_factor then
		return _assets.icons.compose_icons("default", medium_icon(tint), medium_gear(machine_tier))
	elseif scale_factor > 1 then
		return _assets.icons.compose_icons("default", standard_icon(tint), standard_gear(machine_tier))
	else
		return _assets.icons.compose_icons("default", mini_icon(tint), mini_gear(machine_tier))
	end
end

local AssemblingMachineGraphicsPack =
	require("__reskins-assets-api__.graphics-packs.base.assembling-machine-graphics-pack")

local entities = {
	["nullius-small-assembler-1"] = {
		type = "assembling-machine",
		tier = 1,
		prog_tier = 1,
		machine_tier = 1, -- crafting speed: 0.5
		scale_factor = 2 / 3,
	},
	["nullius-small-assembler-2"] = {
		type = "assembling-machine",
		tier = 2,
		prog_tier = 2,
		machine_tier = 2, -- crafting speed: 1
		scale_factor = 2 / 3,
	},
	["nullius-small-assembler-3"] = {
		type = "assembling-machine",
		tier = 3,
		prog_tier = 3,
		machine_tier = 3, -- crafting speed: 2
		scale_factor = 2 / 3,
	},
	["nullius-medium-assembler-1"] = {
		type = "assembling-machine",
		tier = 1,
		prog_tier = 1,
		machine_tier = 2, -- crafting speed: 1
	},
	["nullius-medium-assembler-2"] = {
		type = "assembling-machine",
		tier = 2,
		prog_tier = 2,
		machine_tier = 3, -- crafting speed: 2
	},
	["nullius-medium-assembler-3"] = {
		type = "assembling-machine",
		tier = 3,
		prog_tier = 3,
		machine_tier = 4, -- crafting speed: 4
	},
	["nullius-large-assembler-1"] = {
		type = "assembling-machine",
		tier = 1,
		prog_tier = 2,
		machine_tier = 5, -- crafting speed: 4
		scale_factor = 4 / 3,
	},
	["nullius-large-assembler-2"] = {
		type = "assembling-machine",
		tier = 2,
		prog_tier = 3,
		machine_tier = 6, -- crafting speed: 8
		scale_factor = 4 / 3,
	},
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	_lib.create_explosions_and_particles(name, {
		base_entity_name = "assembling-machine-1",
		type = "assembling-machine",
		tint = tint,
		particles = {
			["big"] = 1,
			["medium"] = 2,
		},
	})

	local corpse = _lib.create_remnant(name, {
		base_entity_name = "assembling-machine-1",
		type = "assembling-machine",
	})

	local graphics_pack = AssemblingMachineGraphicsPack:configure({
		tint = tint,
		machine_tier = options.machine_tier,
	})

	graphics_pack:apply_to_entity(entity)
	graphics_pack:apply_to_corpse(corpse)
	if options.scale_factor then
		_sprites.rescale_prototype(corpse, options.scale_factor)
	end

	local icon = resolve_icon(tint, options.machine_tier, options.scale_factor)

	---@type DeferrableIconData
	local deferrable_icon = {
		name = name,
		type_name = options.type,
		icon_data = _framework.tiers.add_tier_labels_to_icons(tier, icon),
	}

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
