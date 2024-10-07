extends State

@export var pursue_state: State
@export var fire_state: State
@export var npc_data: Node
@export var npc: CharacterBody3D

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

var aiming_time_countdown: float

func enter():
	aiming_time_countdown = npc_data.aiming_time_secs


func physics_process(delta: float) -> void:
	
	var distance_to_player: float = npc.global_position.distance_to(player.global_position)
	if aiming_time_countdown > 0:
		aiming_time_countdown -= delta
	
	if distance_to_player > npc_data.firing_range:
		change_state(pursue_state)
	else:
		change_state(fire_state)
	return 


func exit():
	aiming_time_countdown = npc_data.aiming_time_secs
