extends CharacterBody3D

@export var animations: AnimatedSprite3D
# @export var state_machine: Node
@export var shotgun_monk_data: Node

var last_damage_taken: float

## Referred to by state machine branches to determine whether collision mesh
## has already been turned off
var is_dead: bool = false

func _ready() -> void:
	return

# func taken_hit(damage: float) -> void:
# 	last_damage_taken = damage
# 	state_machine.taken_hit()

