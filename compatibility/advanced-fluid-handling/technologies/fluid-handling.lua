---@namespace Reskins.Nullius.Compatibility.AdvancedFluidHandling

if not mods["underground-pipe-pack"] then
	return
end

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }
local FluidHandling = require("__reskins-assets-api__.assets.base.technologies.fluid-handling")

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
	if data.raw.technology[name] then
		local tint = _framework.tiers.get_tint(_framework.tiers.get_tier(options))

		_sprite_utils.icons.assign_icons_to_prototype_and_related_prototypes(
			name,
			"technology",
			FluidHandling.get_icon({ tint = tint })
		)
	end
end
