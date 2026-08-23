local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local icon_helpers = require("__reskins-assets-api__.api.icon-helpers")

local robot_frame_icon_creator_fn = icon_helpers.make_tinted_three_layer_icon_creator_fn({
	folder = "__reskins-assets-base__/graphics/icons",
	icon_name = "flying-robot-frame",
})

local robot_frames = {
	["nullius-robot-frame-1"] = { tier = 1, prog_tier = 2 },
	["nullius-robot-frame-2"] = { tier = 2, prog_tier = 3 },
	["nullius-robot-frame-3"] = { tier = 3, prog_tier = 4 },
	["nullius-robot-frame-4"] = { tier = 4, prog_tier = 5 },
}

for name, options in pairs(robot_frames) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)
	local index = name:match("(%d+)$")

	local legacy_item_name = "nullius-legacy-robot-frame-" .. index

	local function assign_to(item_name)
		local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
			tier = tier,
			name = item_name,
			type_name = "item",
			icon_data = robot_frame_icon_creator_fn(tint),
		})
		_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)
	end

	assign_to(name)
	assign_to(legacy_item_name)
end
