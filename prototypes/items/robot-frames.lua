local _lib = require("_lib")
local _framework = {
	tiers = require("__reskins-framework__.api.tiers"),
}

if not _lib.is_scope_enabled("items-and-fluids") then
	return
end

local ICON_PATH = "__reskins-assets-base__/graphics/icons/flying-robot-frame/flying-robot-frame-icon-"

local robot_frames = {
	["nullius-robot-frame-1"] = { tier = 1, prog_tier = 2 },
	["nullius-robot-frame-2"] = { tier = 2, prog_tier = 3 },
	["nullius-robot-frame-3"] = { tier = 3, prog_tier = 4 },
	["nullius-robot-frame-4"] = { tier = 4, prog_tier = 5 },
}

local function assign_icon(type_name, name, icon)
	_lib.assign_icons_to_prototype(type_name, name, icon)
end

for name, options in pairs(robot_frames) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)
	local index = name:match("(%d+)$")
	local icon = _lib.add_tier_labels_to_icons(
		tier,
		_lib.make_layered_icon(ICON_PATH, tint, nil, 64, 4)
	)
	local boxed_icon = _lib.make_boxed_icon(icon)

	assign_icon("item", name, icon)
	assign_icon("recipe", name, icon)
	assign_icon("recipe", "nullius-legacy-robot-frame-" .. index, icon)

	assign_icon("item", "nullius-box-robot-frame-" .. index, boxed_icon)
	assign_icon("recipe", "nullius-boxed-robot-frame-" .. index, boxed_icon)
	assign_icon("recipe", "nullius-box-robot-frame-" .. index, boxed_icon)
	assign_icon("recipe", "nullius-unbox-robot-frame-" .. index, boxed_icon)
	assign_icon("recipe", "nullius-legacy-boxed-robot-frame-" .. index, boxed_icon)
end
