local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}

local entities = {
	["nullius-cargo-wagon-1"] = { type = "cargo-wagon", tier = 1, prog_tier = 1 },
	["nullius-cargo-wagon-2"] = { type = "cargo-wagon", tier = 2, prog_tier = 2 },
	["nullius-cargo-wagon-3"] = { type = "cargo-wagon", tier = 3, prog_tier = 3 },
}

for name, options in pairs(entities) do
	local entity = data.raw[options.type][name]
	if not entity then
		goto continue
	end

	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = name,
		type_name = entity.type,
		icon_data = _assets.create_icon.train_cargo_wagon(tint),
	})

	_assets.icons.assign_deferrable_icon(deferrable_icon)

	::continue::
end
