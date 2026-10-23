---@using data

---@alias PipeVisualizationOffset 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15
---@alias PipeToGroundVisualizationOffset 0|1|2|3|4
---@alias ArrowVisualizationOffset { x: 0|1|2|3|4, y: 0|1|2 }

---@class OrientedArrowVisualizationOffsets
---@field north ArrowVisualizationOffset
---@field east ArrowVisualizationOffset
---@field south ArrowVisualizationOffset
---@field west ArrowVisualizationOffset

local M = {}

---@param offset ArrowVisualizationOffset
---@return Sprite
function M.arrow_visualization_layer(offset)
	return {
		filename = "__reskins-assets-assorted__/graphics/entity/surface-junction/visualizations.png",
		priority = "extra-high",
		x = offset.x * 64,
		y = offset.y * 64,
		size = 64,
		scale = 0.5,
		flags = { "icon" },
	}
end

---@param offset PipeToGroundVisualizationOffset
---@return Sprite
function M.pipe_to_ground_visualization_layer(offset)
	return {
		filename = "__base__/graphics/entity/pipe-to-ground/visualization.png",
		priority = "extra-high",
		x = offset * 64,
		size = 64,
		scale = 0.5,
		flags = { "icon" },
	}
end

---@param offset PipeToGroundVisualizationOffset
---@return Sprite
function M.pipe_to_ground_disabled_visualization_layer(offset)
	return {
		filename = "__base__/graphics/entity/pipe-to-ground/disabled-visualization.png",
		priority = "extra-high",
		x = offset * 64,
		size = 64,
		scale = 0.5,
		flags = { "icon" },
	}
end

---@param offset PipeVisualizationOffset
---@return Sprite
function M.pipe_visualization_layer(offset)
	return {
		filename = "__base__/graphics/entity/pipe/visualization.png",
		priority = "extra-high",
		x = offset * 64,
		size = 64,
		scale = 0.5,
		flags = { "icon" },
	}
end

---@param offset PipeVisualizationOffset
---@return Sprite
function M.pipe_disabled_visualization_layer(offset)
	return {
		filename = "__base__/graphics/entity/pipe/disabled-visualization.png",
		priority = "extra-high",
		x = offset * 64,
		size = 64,
		scale = 0.5,
		flags = { "icon" },
	}
end

---@param offsets OrientedArrowVisualizationOffsets
---@return Sprite4Way
function M.make_pipe_to_ground_visualization(offsets)
	return {
		north = {
			layers = {
				M.arrow_visualization_layer(offsets.north),
				M.pipe_to_ground_visualization_layer(1),
			},
		},
		east = {
			layers = {
				M.arrow_visualization_layer(offsets.east),
				M.pipe_to_ground_visualization_layer(2),
			},
		},
		south = {
			layers = {
				M.arrow_visualization_layer(offsets.south),
				M.pipe_to_ground_visualization_layer(3),
			},
		},
		west = {
			layers = {
				M.arrow_visualization_layer(offsets.west),
				M.pipe_to_ground_visualization_layer(4),
			},
		},
	}
end

---@param offsets OrientedArrowVisualizationOffsets
---@return Sprite4Way
function M.make_pipe_to_ground_disabled_visualization(offsets)
	return {
		north = {
			layers = {
				M.arrow_visualization_layer(offsets.north),
				M.pipe_to_ground_disabled_visualization_layer(1),
			},
		},
		east = {
			layers = {
				M.arrow_visualization_layer(offsets.east),
				M.pipe_to_ground_disabled_visualization_layer(2),
			},
		},
		south = {
			layers = {
				M.arrow_visualization_layer(offsets.south),
				M.pipe_to_ground_disabled_visualization_layer(3),
			},
		},
		west = {
			layers = {
				M.arrow_visualization_layer(offsets.west),
				M.pipe_to_ground_disabled_visualization_layer(4),
			},
		},
	}
end

---@param pipe_offset PipeVisualizationOffset
---@param arrow_offset ArrowVisualizationOffset
---@return Sprite
function M.make_pipe_visualization(pipe_offset, arrow_offset)
	return {
		layers = {
			M.arrow_visualization_layer(arrow_offset),
			M.pipe_visualization_layer(pipe_offset),
		},
	}
end

---@param pipe_offset PipeVisualizationOffset
---@param arrow_offset ArrowVisualizationOffset
---@return Sprite
function M.make_pipe_disabled_visualization(pipe_offset, arrow_offset)
	return {
		layers = {
			M.arrow_visualization_layer(arrow_offset),
			M.pipe_disabled_visualization_layer(pipe_offset),
		},
	}
end

---@param sprite Sprite?
---@param offset ArrowVisualizationOffset
---@param shift Vector?
---@return Sprite?
function M.append_in_world_visualization_layer(sprite, offset, shift)
	if not sprite then
		return
	end
	local copy = util.copy(sprite)

	local layers = copy.layers or { copy }
	table.insert(layers, {
		filename = "__reskins-assets-assorted__/graphics/entity/surface-junction/in-world-visualizations.png",
		priority = "extra-high",
		x = offset.x * 30,
		y = offset.y * 30,
		size = 30,
		shift = shift,
		scale = 0.5,
		blend_mode = "multiplicative-with-alpha",
	})
	table.insert(layers, {
		filename = "__reskins-assets-assorted__/graphics/entity/surface-junction/in-world-visualizations-highlights.png",
		priority = "extra-high",
		x = offset.x * 30,
		y = offset.y * 30,
		size = 30,
		shift = shift,
		scale = 0.5,
		blend_mode = "additive-soft",
	})

	return { layers = layers }
end

---@param sprite Sprite4Way?
---@param offsets OrientedArrowVisualizationOffsets
---@param shift Vector?
---@return Sprite4Way?
function M.append_in_world_visualizations(sprite, offsets, shift)
	if sprite then
		return {
			north = M.append_in_world_visualization_layer(sprite.north, offsets.north, shift),
			east = M.append_in_world_visualization_layer(sprite.east, offsets.east, shift),
			south = M.append_in_world_visualization_layer(sprite.south, offsets.south, shift),
			west = M.append_in_world_visualization_layer(sprite.west, offsets.west, shift),
		}
	end
end

function M.visualization_offsets()
	return {
		single = {
			north = { x = 0, y = 0 },
			east = { x = 1, y = 0 },
			south = { x = 2, y = 0 },
			west = { x = 3, y = 0 },
		},
		corner = {
			north = { x = 0, y = 1 },
			east = { x = 1, y = 1 },
			south = { x = 2, y = 1 },
			west = { x = 3, y = 1 },
		},
		straight_horizontal = {
			north = { x = 4, y = 1 },
			east = { x = 4, y = 0 },
			south = { x = 4, y = 1 },
			west = { x = 4, y = 0 },
		},
		straight_vertical = {
			north = { x = 4, y = 0 },
			east = { x = 4, y = 1 },
			south = { x = 4, y = 0 },
			west = { x = 4, y = 1 },
		},
		t = {
			north = { x = 0, y = 2 },
			east = { x = 1, y = 2 },
			south = { x = 2, y = 2 },
			west = { x = 3, y = 2 },
		},
		cross = {
			north = { x = 4, y = 2 },
			east = { x = 4, y = 2 },
			south = { x = 4, y = 2 },
			west = { x = 4, y = 2 },
		},
	}
end

return M
