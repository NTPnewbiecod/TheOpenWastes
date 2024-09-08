@tool
extends Node3D

@export var wall_grid: GridMap

enum wall_variant{
	full_wall = 7,
	windows_x3 = 8,
	windows_x2 = 9,
	windows_x1 = 10,
	door_windows = 11,
}

## enable
@export var enable: bool = false:
	set(new_val):
		enable = new_val
		return


@export var run: bool = false:
	set(new_val):
		run = new_val
		_ready()
		run = false


func _ready() -> void:
	if enable:
		wall_handler()
	if not enable:
		var used_cell_pos_list: Array[Vector3i] = wall_grid.get_used_cells()
		var used_cell_orian_list: Array = used_cell_pos_list.map(wall_grid.get_cell_item_orientation)
		for i in used_cell_pos_list.size():
			wall_grid.set_cell_item(used_cell_pos_list[i], wall_variant.full_wall, used_cell_orian_list[i])
		
	return


func wall_handler() -> void:
	var used_cell_pos_list: Array[Vector3i] = wall_grid.get_used_cells()
	var used_cell_orian_list: Array = used_cell_pos_list.map(wall_grid.get_cell_item_orientation)
	for i in used_cell_pos_list.size():
		# put door on first floor
		# 1/4 chance to be a door
		if used_cell_pos_list[i].y == 0 and randi_range(0, 4) == 0:
			wall_grid.set_cell_item(used_cell_pos_list[i], wall_variant.door_windows, used_cell_orian_list[i])
		else:
			wall_grid.set_cell_item(used_cell_pos_list[i], wall_variant.windows_x2, used_cell_orian_list[i])
		pass
	return

# func _process(delta: float) -> void:
# 	pass
