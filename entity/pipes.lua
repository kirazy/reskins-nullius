---@param i integer
local function make_visualization(i)
	return {
		filename = "__base__/graphics/entity/pipe/visualization.png",
		priority = "extra-high",
		x = i * 64,
		size = 64,
		scale = 0.5,
		flags = { "icon" },
	}
end

---@param i integer
local function make_disabled_visualization(i)
	return {
		filename = "__base__/graphics/entity/pipe/disabled-visualization.png",
		priority = "extra-high",
		x = i * 64,
		size = 64,
		scale = 0.5,
		flags = { "icon" },
	}
end

local function pipe_pictures(pipe_type)
	return {
		straight_vertical_single = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-ending-up.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		straight_vertical = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-straight-vertical.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		straight_vertical_window = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-straight-vertical-window.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		straight_horizontal_window = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-straight-horizontal-window.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		straight_horizontal = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-straight-horizontal.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		corner_up_right = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-corner-up-right.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		corner_up_left = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-corner-up-left.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		corner_down_right = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-corner-down-right.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		corner_down_left = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-corner-down-left.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		t_up = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-t-up.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		t_down = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-t-down.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		t_right = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-t-right.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		t_left = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-t-left.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		cross = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-cross.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		ending_up = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-ending-up.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		ending_down = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-ending-down.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		ending_right = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-ending-right.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		ending_left = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-ending-left.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		horizontal_window_background = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-horizontal-window-background.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		vertical_window_background = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-vertical-window-background.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		fluid_background = {
			filename = "__base__/graphics/entity/pipe/fluid-background.png",
			priority = "extra-high",
			width = 64,
			height = 40,
			scale = 0.5,
		},
		low_temperature_flow = {
			filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
			priority = "extra-high",
			width = 160,
			height = 18,
		},
		middle_temperature_flow = {
			filename = "__base__/graphics/entity/pipe/fluid-flow-medium-temperature.png",
			priority = "extra-high",
			width = 160,
			height = 18,
		},
		high_temperature_flow = {
			filename = "__base__/graphics/entity/pipe/fluid-flow-high-temperature.png",
			priority = "extra-high",
			width = 160,
			height = 18,
		},
		gas_flow = {
			filename = "__base__/graphics/entity/pipe/steam.png",
			priority = "extra-high",
			line_length = 10,
			width = 48,
			height = 30,
			frame_count = 60,
		},
		straight_vertical_single_visualization = make_visualization(0),
		straight_vertical_visualization = make_visualization(5),
		straight_vertical_window_visualization = make_visualization(5),
		straight_horizontal_window_visualization = make_visualization(10),
		straight_horizontal_visualization = make_visualization(10),
		corner_up_right_visualization = make_visualization(3),
		corner_up_left_visualization = make_visualization(9),
		corner_down_right_visualization = make_visualization(6),
		corner_down_left_visualization = make_visualization(12),
		t_up_visualization = make_visualization(11),
		t_down_visualization = make_visualization(14),
		t_right_visualization = make_visualization(7),
		t_left_visualization = make_visualization(13),
		cross_visualization = make_visualization(15),
		ending_up_visualization = make_visualization(1),
		ending_down_visualization = make_visualization(4),
		ending_right_visualization = make_visualization(2),
		ending_left_visualization = make_visualization(8),
		straight_vertical_single_disabled_visualization = make_disabled_visualization(0),
		straight_vertical_disabled_visualization = make_disabled_visualization(5),
		straight_vertical_window_disabled_visualization = make_disabled_visualization(5),
		straight_horizontal_window_disabled_visualization = make_disabled_visualization(10),
		straight_horizontal_disabled_visualization = make_disabled_visualization(10),
		corner_up_right_disabled_visualization = make_disabled_visualization(3),
		corner_up_left_disabled_visualization = make_disabled_visualization(9),
		corner_down_right_disabled_visualization = make_disabled_visualization(6),
		corner_down_left_disabled_visualization = make_disabled_visualization(12),
		t_up_disabled_visualization = make_disabled_visualization(11),
		t_down_disabled_visualization = make_disabled_visualization(14),
		t_right_disabled_visualization = make_disabled_visualization(7),
		t_left_disabled_visualization = make_disabled_visualization(13),
		cross_disabled_visualization = make_disabled_visualization(15),
		ending_up_disabled_visualization = make_disabled_visualization(1),
		ending_down_disabled_visualization = make_disabled_visualization(4),
		ending_right_disabled_visualization = make_disabled_visualization(2),
		ending_left_disabled_visualization = make_disabled_visualization(8),
	}
end

local function pipe_to_ground_pictures(pipe_type)
	return {
		north = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-to-ground-up.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		south = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-to-ground-down.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		east = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-to-ground-right.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
		west = {
			filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-to-ground-left.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5,
		},
	}
end

local function pipe_covers_pictures(pipe_type)
	return {
		north = {
			layers = {
				{
					filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-cover-north.png",
					priority = "extra-high",
					width = 128,
					height = 128,
					scale = 0.5,
				},
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-north-shadow.png",
					priority = "extra-high",
					width = 128,
					height = 128,
					scale = 0.5,
					draw_as_shadow = true,
				},
			},
		},
		east = {
			layers = {
				{
					filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-cover-east.png",
					priority = "extra-high",
					width = 128,
					height = 128,
					scale = 0.5,
				},
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-east-shadow.png",
					priority = "extra-high",
					width = 128,
					height = 128,
					scale = 0.5,
					draw_as_shadow = true,
				},
			},
		},
		south = {
			layers = {
				{
					filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-cover-south.png",
					priority = "extra-high",
					width = 128,
					height = 128,
					scale = 0.5,
				},
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-south-shadow.png",
					priority = "extra-high",
					width = 128,
					height = 128,
					scale = 0.5,
					draw_as_shadow = true,
				},
			},
		},
		west = {
			layers = {
				{
					filename = "__boblogistics__/graphics/entity/pipe/" .. pipe_type .. "/pipe-cover-west.png",
					priority = "extra-high",
					width = 128,
					height = 128,
					scale = 0.5,
				},
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-west-shadow.png",
					priority = "extra-high",
					width = 128,
					height = 128,
					scale = 0.5,
					draw_as_shadow = true,
				},
			},
		},
	}
end

-- data.raw.item["pipe"].icons[1].icon = "__boblogistics__/graphics/icons/pipe/iron-pipe.png"
data.raw.item["nullius-pipe-2"].icons[1].icon = "__boblogistics__/graphics/icons/pipe/steel-pipe.png"
data.raw.item["nullius-pipe-3"].icons[1].icon = "__boblogistics__/graphics/icons/pipe/bronze-pipe.png"
data.raw.item["nullius-pipe-4"].icons[1].icon = "__boblogistics__/graphics/icons/pipe/titanium-pipe.png"

data.raw.recipe["nullius-plastic-pipe"].icons[1].icon = "__boblogistics__/graphics/icons/pipe/steel-pipe.png"

data.raw.pipe["pipe"].pictures = pipe_pictures("iron")
data.raw.pipe["nullius-pipe-2"].pictures = pipe_pictures("steel")
data.raw.pipe["nullius-pipe-3"].pictures = pipe_pictures("bronze")
data.raw.pipe["nullius-pipe-4"].pictures = pipe_pictures("titanium")

data.raw.pipe["pipe"].fluid_box.pipe_covers = pipe_covers_pictures("iron")
data.raw.pipe["nullius-pipe-2"].fluid_box.pipe_covers = pipe_covers_pictures("steel")
data.raw.pipe["nullius-pipe-3"].fluid_box.pipe_covers = pipe_covers_pictures("bronze")
data.raw.pipe["nullius-pipe-4"].fluid_box.pipe_covers = pipe_covers_pictures("titanium")

-- data.raw.item["pipe-to-ground"].icons[1].icon = "__boblogistics__/graphics/icons/pipe/iron-pipe-to-ground.png"
data.raw.item["nullius-underground-pipe-2"].icons[1].icon =
	"__boblogistics__/graphics/icons/pipe/steel-pipe-to-ground.png"
data.raw.item["nullius-underground-pipe-3"].icons[1].icon =
	"__boblogistics__/graphics/icons/pipe/bronze-pipe-to-ground.png"
data.raw.item["nullius-underground-pipe-4"].icons[1].icon =
	"__boblogistics__/graphics/icons/pipe/titanium-pipe-to-ground.png"

data.raw["pipe-to-ground"]["pipe-to-ground"].pictures = pipe_to_ground_pictures("iron")
data.raw["pipe-to-ground"]["nullius-underground-pipe-2"].pictures = pipe_to_ground_pictures("steel")
data.raw["pipe-to-ground"]["nullius-underground-pipe-3"].pictures = pipe_to_ground_pictures("bronze")
data.raw["pipe-to-ground"]["nullius-underground-pipe-4"].pictures = pipe_to_ground_pictures("titanium")

data.raw["pipe-to-ground"]["pipe-to-ground"].fluid_box.pipe_covers = pipe_covers_pictures("iron")
data.raw["pipe-to-ground"]["nullius-underground-pipe-2"].fluid_box.pipe_covers = pipe_covers_pictures("steel")
data.raw["pipe-to-ground"]["nullius-underground-pipe-3"].fluid_box.pipe_covers = pipe_covers_pictures("bronze")
data.raw["pipe-to-ground"]["nullius-underground-pipe-4"].fluid_box.pipe_covers = pipe_covers_pictures("titanium")
