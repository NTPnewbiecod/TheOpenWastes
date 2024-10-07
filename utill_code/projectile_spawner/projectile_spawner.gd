extends Node3D

@export_group("test")
@export var Projectile: PackedScene
@export var muzzle_velocity: float = 1000


func fire() -> void:
	return


func _ready() -> void:
	return

func _physics_process(_delta: float) -> void:
	var bullet: Node3D = Projectile.instantiate()
	add_child(bullet)
	for i in get_children():
		if i is Projectile:
			i.enable = true
	return