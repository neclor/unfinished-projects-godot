extends Node2D


@onready var arena_tile_map = $ArenaTileMap


const ARENA_RADIUS = 17
const CELL_SIZE = 64


func _ready():
	create_arena()


func create_arena():
	arena_tile_map.set_cells_terrain_connect(0, create_cells_array(), 0, 0)


func create_cells_array():
	var cells_array := []
	for i in range(-ARENA_RADIUS, ARENA_RADIUS):
		for j in range(-ARENA_RADIUS, ARENA_RADIUS):
			cells_array.append(Vector2i(i, j))
	return cells_array
