---@namespace Reskins.Nullius.Compatibility.AdvancedFluidHandling

if not mods["underground-pipe-pack"] then
	return
end

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }

local technologies = {
	["advanced-underground-piping"] = {
		tier = 2,
		prog_tier = 2,
	},
	["advanced-underground-piping-t2"] = {
		tier = 3,
		prog_tier = 3,
	},
	["advanced-underground-piping-t3"] = {
		tier = 4,
		prog_tier = 4,
	},
}

for name, options in pairs(technologies) do
	local technology = data.raw.technology[name]
	if technology then
		local tier = _framework.tiers.get_tier(options)

		_sprite_utils.icons.clear_icon_from_prototype(technology)
		technology.icons = {
			{
				icon = "__reskins-assets-base__/graphics/technology/fluid-handling/fluid-handling-base.png",
				icon_size = 256,
			},
			{
				icon = "__reskins-assets-base__/graphics/technology/fluid-handling/fluid-handling-mask.png",
				icon_size = 256,
				tint = _framework.tiers.get_tint(tier),
			},
			{
				icon = "__reskins-assets-base__/graphics/technology/fluid-handling/fluid-handling-highlights.png",
				icon_size = 256,
				tint = { 1, 1, 1, 0 },
			},
		}
	end
end
