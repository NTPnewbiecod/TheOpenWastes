extends State

@export var aim_state: State
@export var idle_state: State
@export var npc_data: Node
@export var npc: CharacterBody3D
@export var nav_agent: NavigationAgent3D

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group('player')
@onready var gravity: float = ProjectSettings.get('physics/3d/default_gravity')

var current_pursue_time_secs: float

func enter() -> void:
	current_pursue_time_secs = npc_data.minimum_pursue_time_secs


func physics_process(delta: float) -> void:
	var distance_to_player: float = npc.global_position.distance_to(player.global_position)
	
	if distance_to_player < npc_data.firing_range:
		if current_pursue_time_secs <= 0:
			change_state(aim_state)
		else:
			move_outside_navmesh(delta)
	elif distance_to_player > npc_data.minimum_idle_range:
		change_state(idle_state)
	else:
		move_outside_navmesh(delta)
	return


func move_outside_navmesh(delta) -> void:
	current_pursue_time_secs -= delta
	
	var direction: Vector3 = player.global_position - npc.global_position
	direction = direction.normalized()
	
	var velocity: Vector3 = direction * npc_data.move_speed
	velocity.y = 0 - (gravity * delta)
	
	npc.velocity = velocity
	npc.move_and_slide()
	
	npc.look_at(npc.global_position + direction, Vector3.UP)
	return
