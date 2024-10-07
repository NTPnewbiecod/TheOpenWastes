@icon("res://images/Icons/pistol_icon.png")

extends Node

const PROJECTILE_PATH: String = "res://Scenes/miscellaneous/projectile_tracer.tscn"
var Projectile = preload(PROJECTILE_PATH)

var direction: Vector3

@onready var player = get_tree().get_nodes_in_group("player")[0] as CharacterBody3D
@onready var camera = player.get_node("Head/Camera3D") as Camera3D
@onready var projectile_instance: Node3D

@export var character_collision: CollisionShape3D

func _on_player_arm_with_pistol_root_weapon_fired() -> void:
	normalised_direction()
	instantiate_projectile()
	position_projectile_instance()


func normalised_direction() -> void:
	direction = camera.global_transform.basis.z.normalized()


func instantiate_projectile() -> void:
	projectile_instance = Projectile.instantiate()
	
	# Pass necessary data to the Projectile
	projectile_instance.set_up_variables(
		direction,
		player.pistol_projectile_speed,
		player.pistol_projectile_life_secs,
		player.pistol_projectile_max_damage,
		character_collision
	)
	
	add_child(projectile_instance)


func position_projectile_instance() -> void:
	var projectile_instance_position: Vector3 = camera.global_transform.origin
	
	# Tweak the spawn point of the Projectile
	var x_rotation_vector = camera.global_transform.basis.x.normalized()
	var y_rotation_vector = camera.global_transform.basis.y.normalized()
	projectile_instance_position += player.pistol_projectile_spawn_x_offset * x_rotation_vector
	projectile_instance_position += player.pistol_projectile_spawn_y_offset * y_rotation_vector
	projectile_instance_position += player.pistol_projectile_spawn_distance_offset * direction
	
	projectile_instance.global_transform.origin = projectile_instance_position
