---@using data

local _framework = { tiers = require("__reskins-framework__.api.tiers") }
local _assets = {
	defines = require("__reskins-assets-api__.api.defines"),
	icons = require("__reskins-assets-api__.api.icons"),
	create_icon = require("__reskins-assets-api__.assets.base.base-icons"),
}
local _sprite_utils = { icons = require("__reskins-sprite-utils__.icons") }
local _lib = require("_lib")

local turbines = {
	open = {
		standard = {
			data.raw.furnace["nullius-turbine-open-standard-1"],
			data.raw.furnace["nullius-turbine-open-standard-2"],
			data.raw.furnace["nullius-turbine-open-standard-3"],
		},
		exhaust = {
			data.raw.furnace["nullius-turbine-open-exhaust-1"],
			data.raw.furnace["nullius-turbine-open-exhaust-2"],
			data.raw.furnace["nullius-turbine-open-exhaust-3"],
		},
		backup = {
			data.raw.furnace["nullius-turbine-open-backup-1"],
			data.raw.furnace["nullius-turbine-open-backup-2"],
			data.raw.furnace["nullius-turbine-open-backup-3"],
		},
	},
	closed = {
		standard = {
			data.raw.furnace["nullius-turbine-closed-standard-1"],
			data.raw.furnace["nullius-turbine-closed-standard-2"],
			data.raw.furnace["nullius-turbine-closed-standard-3"],
		},
		exhaust = {
			data.raw.furnace["nullius-turbine-closed-exhaust-1"],
			data.raw.furnace["nullius-turbine-closed-exhaust-2"],
			data.raw.furnace["nullius-turbine-closed-exhaust-3"],
		},
		backup = {
			data.raw.furnace["nullius-turbine-closed-backup-1"],
			data.raw.furnace["nullius-turbine-closed-backup-2"],
			data.raw.furnace["nullius-turbine-closed-backup-3"],
		},
	},
}

local generators = {
	open = {
		standard = {
			data.raw.generator["nullius-turbine-generator-open-standard-1"],
			data.raw.generator["nullius-turbine-generator-open-standard-2"],
			data.raw.generator["nullius-turbine-generator-open-standard-3"],
		},
		exhaust = {
			data.raw.generator["nullius-turbine-generator-open-exhaust-1"],
			data.raw.generator["nullius-turbine-generator-open-exhaust-2"],
			data.raw.generator["nullius-turbine-generator-open-exhaust-3"],
		},
		backup = {
			data.raw.generator["nullius-turbine-generator-open-backup-1"],
			data.raw.generator["nullius-turbine-generator-open-backup-2"],
			data.raw.generator["nullius-turbine-generator-open-backup-3"],
		},
	},
	closed = {
		standard = {
			data.raw.generator["nullius-turbine-generator-closed-standard-1"],
			data.raw.generator["nullius-turbine-generator-closed-standard-2"],
			data.raw.generator["nullius-turbine-generator-closed-standard-3"],
		},
		exhaust = {
			data.raw.generator["nullius-turbine-generator-closed-exhaust-1"],
			data.raw.generator["nullius-turbine-generator-closed-exhaust-2"],
			data.raw.generator["nullius-turbine-generator-closed-exhaust-3"],
		},
		backup = {
			data.raw.generator["nullius-turbine-generator-closed-backup-1"],
			data.raw.generator["nullius-turbine-generator-closed-backup-2"],
			data.raw.generator["nullius-turbine-generator-closed-backup-3"],
		},
	},
}

for closure, modes in pairs(turbines) do
	for mode, tiers in pairs(modes) do
		for tier, prototype in pairs(tiers) do
			if closure == "closed" then
				prototype.graphics_set = util.copy(turbines.open[mode][tier].graphics_set)
			elseif tier < 3 then
				prototype.graphics_set = util.copy(tiers[3].graphics_set)
			end
		end
	end
end

for closure, modes in pairs(generators) do
	for mode, tiers in pairs(modes) do
		for tier, prototype in pairs(tiers) do
			if closure == "closed" then
				prototype.vertical_animation = util.copy(generators.open[mode][tier].vertical_animation)
				prototype.horizontal_animation = util.copy(generators.open[mode][tier].horizontal_animation)
			elseif tier < 3 then
				prototype.vertical_animation = util.copy(tiers[3].vertical_animation)
				prototype.horizontal_animation = util.copy(tiers[3].horizontal_animation)
			end
		end
	end
end

for closure, modes in pairs(turbines) do
	for mode, tiers in pairs(modes) do
		for tier, prototype in pairs(tiers) do
			local color_tier = tier
			local tint = _framework.tiers.get_tint(color_tier)

			for direction, animation in pairs(prototype.graphics_set.idle_animation) do
				animation.layers[1].tint = nil

				if direction == "north" or direction == "south" then
					table.insert(animation.layers, 3, {
						filename = "__reskins-assets-base__/graphics/entity/steam-turbine/steam-turbine-vertical-mask.png",
						width = 217,
						height = 347,
						frame_count = 1,
						line_length = 1,
						shift = util.by_pixel(4.75, 6.75),
						tint = tint,
						scale = 0.5,
					})

					table.insert(animation.layers, 4, {
						filename = "__reskins-assets-base__/graphics/entity/steam-turbine/steam-turbine-vertical-highlights.png",
						width = 217,
						height = 347,
						frame_count = 1,
						line_length = 1,
						shift = util.by_pixel(4.75, 6.75),
						blend_mode = "additive-soft",
						scale = 0.5,
					})
				else
					table.insert(animation.layers, 3, {
						filename = "__reskins-assets-base__/graphics/entity/steam-turbine/steam-turbine-horizontal-mask.png",
						width = 320,
						height = 245,
						frame_count = 1,
						line_length = 1,
						shift = util.by_pixel(0, -2.75),
						tint = tint,
						scale = 0.5,
					})

					table.insert(animation.layers, 4, {
						filename = "__reskins-assets-base__/graphics/entity/steam-turbine/steam-turbine-horizontal-highlights.png",
						width = 320,
						height = 245,
						frame_count = 1,
						line_length = 1,
						shift = util.by_pixel(0, -2.75),
						blend_mode = "additive-soft",
						scale = 0.5,
					})
				end
			end
		end
	end
end

for closure, modes in pairs(generators) do
	for mode, tiers in pairs(modes) do
		for tier, prototype in pairs(tiers) do
			prototype.vertical_animation.layers[1].tint = nil
			prototype.horizontal_animation.layers[1].tint = nil

			prototype.vertical_animation.layers[3] =
				util.copy(turbines[closure][mode][tier].graphics_set.idle_animation.north.layers[3])
			prototype.vertical_animation.layers[4] =
				util.copy(turbines[closure][mode][tier].graphics_set.idle_animation.north.layers[4])
			prototype.horizontal_animation.layers[3] =
				util.copy(turbines[closure][mode][tier].graphics_set.idle_animation.east.layers[3])
			prototype.horizontal_animation.layers[4] =
				util.copy(turbines[closure][mode][tier].graphics_set.idle_animation.east.layers[4])

			prototype.vertical_animation.layers[3].repeat_count = 8
			prototype.vertical_animation.layers[4].repeat_count = 8
			prototype.horizontal_animation.layers[3].repeat_count = 8
			prototype.horizontal_animation.layers[4].repeat_count = 8
		end
	end
end

for _, modes in pairs(turbines) do
	for _, prototype in pairs(modes.standard) do
		if prototype.graphics_set and prototype.graphics_set.idle_animation then
			for _, animation in pairs(prototype.graphics_set.idle_animation) do
				if animation.layers then
					table.remove(animation.layers, 2)
				end
			end
		end
	end
end

for _, modes in pairs(generators) do
	for _, prototype in pairs(modes.standard) do
		if prototype.vertical_animation and prototype.vertical_animation.layers then
			table.remove(prototype.vertical_animation.layers, 2)
		end

		if prototype.horizontal_animation and prototype.horizontal_animation.layers then
			table.remove(prototype.horizontal_animation.layers, 2)
		end
	end
end

---@type LibHack.ConstructIconInputsOld
local inputs = {
	type = "furnace",
	icon_name = "steam-turbine",
	graphics_mod = "assets-base",
}

local tier_map = {
	["nullius-turbine-open-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-open-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-open-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-open-standard-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-open-standard-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-open-standard-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-open-exhaust-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-open-exhaust-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-open-exhaust-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-open-backup-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-open-backup-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-open-backup-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-closed-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-closed-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-closed-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-closed-standard-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-closed-standard-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-closed-standard-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-closed-exhaust-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-closed-exhaust-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-closed-exhaust-3"] = { tier = 3, prog_tier = 3 },
	["nullius-turbine-closed-backup-1"] = { tier = 1, prog_tier = 1 },
	["nullius-turbine-closed-backup-2"] = { tier = 2, prog_tier = 2 },
	["nullius-turbine-closed-backup-3"] = { tier = 3, prog_tier = 3 },
}

for name, options in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(options)
	local tint = _framework.tiers.get_tint(tier)

	local symbol = name:find("open") and _assets.defines.symbol.aperture_open or _assets.defines.symbol.aperture_closed
	local icon_data = _sprite_utils.icons.compose_icons(
		"default",
		_assets.create_icon.steam_turbine(tint),
		_assets.icons.get_symbol(symbol, tint)
	)

	local deferrable_icon = _framework.tiers.deferrable_icon_with_tier_labels({
		tier = tier,
		name = name,
		type_name = "furnace",
		icon_data = icon_data,
	})

	_sprite_utils.icons.assign_deferrable_icon(deferrable_icon)
end
