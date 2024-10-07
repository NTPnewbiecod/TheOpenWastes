extends Node

@export var npc: CharacterBody3D
@onready var players: CharacterBody3D = get_tree().get_first_node_in_group("player")

func distance_to_player() -> float:
	return npc.global_position.distance_squared_to(players.global_position)
