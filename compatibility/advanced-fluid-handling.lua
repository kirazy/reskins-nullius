if not mods["underground-pipe-pack"] then
	return
end

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
}
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local items = {
	["4-to-4-pipe"] = {
		tier = 4,
		type = "pipe",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 4,
		symbol = "4-4-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["one-to-one-forward-pipe"] = {
		tier = 4,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 4,
		symbol = "1-1-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["one-to-two-perpendicular-pipe"] = {
		tier = 4,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 4,
		symbol = "1-2-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["one-to-three-forward-pipe"] = {
		tier = 4,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 4,
		symbol = "1-3-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["one-to-four-pipe"] = {
		tier = 4,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 4,
		symbol = "1-4-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["underground-cross-pipe"] = {
		tier = 4,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 4,
		symbol = "cross-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["underground-i-pipe"] = {
		tier = 4,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 4,
		symbol = "straight-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["underground-L-pipe"] = {
		tier = 4,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 4,
		symbol = "corner-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["underground-t-pipe"] = {
		tier = 4,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 4,
		symbol = "t-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["one-to-one-forward-t2-pipe"] = {
		tier = 2,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 2,
		symbol = "1-1-junction",
		pipe_material = _assets.defines.pipe_material.aluminum,
	},
	["one-to-two-perpendicular-t2-pipe"] = {
		tier = 2,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 2,
		symbol = "1-2-junction",
		pipe_material = _assets.defines.pipe_material.aluminum,
	},
	["one-to-three-forward-t2-pipe"] = {
		tier = 2,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 2,
		symbol = "1-3-junction",
		pipe_material = _assets.defines.pipe_material.aluminum,
	},
	["one-to-four-t2-pipe"] = {
		tier = 2,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 2,
		symbol = "1-4-junction",
		pipe_material = _assets.defines.pipe_material.aluminum,
	},
	["underground-cross-t2-pipe"] = {
		tier = 2,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 2,
		symbol = "cross-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["underground-i-t2-pipe"] = {
		tier = 2,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 2,
		symbol = "straight-junction",
		pipe_material = _assets.defines.pipe_material.aluminum,
	},
	["underground-L-t2-pipe"] = {
		tier = 2,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 2,
		symbol = "corner-junction",
		pipe_material = _assets.defines.pipe_material.aluminum,
	},
	["underground-t-t2-pipe"] = {
		tier = 2,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 2,
		symbol = "t-junction",
		pipe_material = _assets.defines.pipe_material.aluminum,
	},
	["one-to-one-forward-t3-pipe"] = {
		tier = 3,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 3,
		symbol = "1-1-junction",
		pipe_material = _assets.defines.pipe_material.plastic,
	},
	["one-to-two-perpendicular-t3-pipe"] = {
		tier = 3,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 3,
		symbol = "1-2-junction",
		pipe_material = _assets.defines.pipe_material.plastic,
	},
	["one-to-three-forward-t3-pipe"] = {
		tier = 3,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 3,
		symbol = "1-3-junction",
		pipe_material = _assets.defines.pipe_material.plastic,
	},
	["one-to-four-t3-pipe"] = {
		tier = 3,
		type = "pipe-to-ground",
		icon_name = "pipe-to-ground-flipped",
		prog_tier = 3,
		symbol = "1-4-junction",
		pipe_material = _assets.defines.pipe_material.plastic,
	},
	["underground-cross-t3-pipe"] = {
		tier = 3,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 3,
		symbol = "cross-junction",
		pipe_material = _assets.defines.pipe_material.nitinol,
	},
	["underground-i-t3-pipe"] = {
		tier = 3,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 3,
		symbol = "straight-junction",
		pipe_material = _assets.defines.pipe_material.plastic,
	},
	["underground-L-t3-pipe"] = {
		tier = 3,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 3,
		symbol = "corner-junction",
		pipe_material = _assets.defines.pipe_material.plastic,
	},
	["underground-t-t3-pipe"] = {
		tier = 3,
		type = "pipe-to-ground",
		icon_name = "underground-pipe-junction",
		prog_tier = 3,
		symbol = "t-junction",
		pipe_material = _assets.defines.pipe_material.plastic,
	},
}

for name, options in pairs(items) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local assets_base = "__reskins-assets-assorted__/graphics/icons/"
	local icon_name = options.pipe_material .. "-" .. options.icon_name

	local icon = _sprite_utils.icons.compose_icons(entity.type, {
		icon = assets_base .. "/" .. options.icon_name .. "/" .. icon_name .. ".png",
		icon_size = 64,
		scale = 0.5,
	}, _assets.icons.get_tinted_icon(assets_base .. "symbols/" .. options.symbol .. ".png", tint))

	local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
		tier = tier,
		name = name,
		type_name = entity.type,
		icon_data = icon,
	})

	_sprite_utils.icons.apply_icon_assignment(icon_assignment)

	::continue::
end
