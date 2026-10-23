---@using data

local _visualizations = require("visualizations")

if not mods["underground-pipe-pack"] then
	return
end

local visualization_offsets = _visualizations.visualization_offsets()

local pipe_to_ground_entities = {
	"pipe-to-ground",
	"nullius-underground-pipe-2",
	"nullius-underground-pipe-3",
	"nullius-underground-pipe-4",
}

local offsets = {
	north = visualization_offsets.single.south,
	east = visualization_offsets.single.west,
	south = visualization_offsets.single.north,
	west = visualization_offsets.single.east,
}

for _, name in pairs(pipe_to_ground_entities) do
	local entity = data.raw["pipe-to-ground"][name]
	if entity then
		entity.visualization = _visualizations.make_pipe_to_ground_visualization(offsets)
		entity.disabled_visualization = _visualizations.make_pipe_to_ground_disabled_visualization(offsets)
	end
end
