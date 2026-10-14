local _lib = require("_lib")
local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local _base_icons = require("__reskins-assets-api__.assets.base.items.icons")

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
		local icon_assignment = _framework.tiers.icon_assignment_with_tier_labels({
			tier = tier,
			name = item_name,
			type_name = "item",
			icon_data = _base_icons.flying_robot_frame({ tint = tint }),
		})
		_sprite_utils.icons.apply_icon_assignment(icon_assignment)
	end

	assign_to(name)
	assign_to(legacy_item_name)
end
