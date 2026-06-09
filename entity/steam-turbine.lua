local _framework = { tiers = require("__reskins-framework__.api.tiers") }
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
			if closure == "closed" then
				color_tier = color_tier + 3
			end
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
		for _, animation in pairs(prototype.graphics_set.idle_animation) do
			table.remove(animation.layers, 2)
		end
	end
end

for _, modes in pairs(generators) do
	for _, prototype in pairs(modes.standard) do
		table.remove(prototype.vertical_animation.layers, 2)
		table.remove(prototype.horizontal_animation.layers, 2)
	end
end

---@type ConstructIconInputsOld
local inputs = {
	type = "furnace",
	icon_name = "steam-turbine",
	graphics_mod = "assets-base",
}

-- Setup defaults.
_lib.set_inputs_defaults(inputs)

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
	["nullius-turbine-closed-1"] = { tier = 1, prog_tier = 4 },
	["nullius-turbine-closed-2"] = { tier = 2, prog_tier = 5 },
	["nullius-turbine-closed-3"] = { tier = 3, prog_tier = 6 },
	["nullius-turbine-closed-standard-1"] = { tier = 1, prog_tier = 4 },
	["nullius-turbine-closed-standard-2"] = { tier = 2, prog_tier = 5 },
	["nullius-turbine-closed-standard-3"] = { tier = 3, prog_tier = 6 },
	["nullius-turbine-closed-exhaust-1"] = { tier = 1, prog_tier = 4 },
	["nullius-turbine-closed-exhaust-2"] = { tier = 2, prog_tier = 5 },
	["nullius-turbine-closed-exhaust-3"] = { tier = 3, prog_tier = 6 },
	["nullius-turbine-closed-backup-1"] = { tier = 1, prog_tier = 4 },
	["nullius-turbine-closed-backup-2"] = { tier = 2, prog_tier = 5 },
	["nullius-turbine-closed-backup-3"] = { tier = 3, prog_tier = 6 },
}

for name, map in pairs(tier_map) do
	local tier = _framework.tiers.get_tier(map)
	inputs.tint = map.tint or _framework.tiers.get_tint(tier)

	_lib.construct_icon(name, tier, inputs)
end
