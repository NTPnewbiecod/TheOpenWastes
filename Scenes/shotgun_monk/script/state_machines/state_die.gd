extends State

@export var collision_shape : CollisionShape3D
@export var death_sound : AudioStreamPlayer3D
@export var npc_data: Node

func enter():
	death_sound.play()

# Delete collision node, so characters and projectiles will no longer interact
	if npc_data.is_dead == true:
		return
	else:
		npc_data.is_dead = true
# Dev2: No, we don't just delete it. Just fucking turn it off.
		collision_shape.disabled = true
