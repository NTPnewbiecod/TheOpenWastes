extends State

signal spawn_projectiles

@export var strafe_state: State
@export var pursue_state: State
@export var npc_data: Node
@export var npc: CharacterBody3D

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group('player')

@export var fire_sound: AudioStreamPlayer3D


var firing_time_countdown: float
var shot_blocked: bool = false

# Stops raycast from colliding with the ground
var raycast_vertical_offset: float = 0.5

func enter():
	firing_time_countdown = npc_data.firing_time_secs
	raycast_check_if_target_blocked()
	if shot_blocked:
		return strafe_state
	else:
		fire_weapon()


func physics_process(delta: float) -> void:
	if shot_blocked or firing_time_countdown <= 0:
		var flip_a_coin = randi()
		if flip_a_coin % 2 == 0:
			change_state(strafe_state)
			return
		else:
			change_state(pursue_state)
			return
	else:
		firing_time_countdown -= delta
		return


func raycast_check_if_target_blocked() -> void:
	# Get access to Godot's space / physics wonders
	var space_state: PhysicsDirectSpaceState3D = $GetSpaceState3D.get_world_3d().get_direct_space_state()
	# Set up raycast from character to player
	var params:PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	
	var ray_from: Vector3 = npc.global_position
	ray_from.y += raycast_vertical_offset
	params.from = ray_from
	
	var ray_to: Vector3 = player.global_position
	ray_to.y += raycast_vertical_offset
	params.to = ray_to
	
	params.exclude = []
	
	# Fire the ray!
	var raycast = space_state.intersect_ray(params)
	if raycast.has("collider") and raycast.collider == player:
		fire_weapon()
	else:
		shot_blocked = true


func fire_weapon() -> void:
	fire_sound.play()
	spawn_projectiles.emit()
