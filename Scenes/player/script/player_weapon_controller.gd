extends Node3D

var weapon_array: Array = ["pistol", "minigun"]
var weapon_selection: int = 0

@export var pistol_scene: PackedScene
@export var minigun_scene: PackedScene

func _unhandled_input(_InputEvent) -> void:
	if Input.is_action_just_pressed("change_weapon"):
		weapon_selection += 1
		if weapon_selection >= weapon_array.size():
			weapon_selection = 0
		change_weapon()
	else:
		return


func change_weapon() -> void:
	clear_weapon()
	call(weapon_array[weapon_selection])


func clear_weapon() -> void:
	for child in get_children():
		child.queue_free()


func pistol() -> void:
	var pistol_instance = pistol_scene.instantiate()
	add_child(pistol_instance)


func minigun() -> void:
	var minigun_instance = minigun_scene.instantiate()
	add_child(minigun_instance)
