extends State

@export var pursue_state: State
@export var npc_data: Node
@export var animation: AnimatedSprite3D
@export var npc: CharacterBody3D

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var gravity: float = ProjectSettings.get("physics/3d/default_gravity")

var character_current_position: Vector3
var character_idle_target_position: Vector3
var player_character_angle: float
var direction_to_idle_target: Vector3

var idle_behaviour_time_secs: float

func enter() -> void:
	idle_behaviour_time_secs = npc_data.idle_behaviour_time_secs
	set_idle_target_position()


func physics_process(delta: float):
	
	if npc.global_position.distance_to(player.global_position) <= npc_data.minimum_idle_range:
		change_state(pursue_state)
		return pursue_state
	
	if idle_behaviour_time_secs <= 0:
		set_idle_target_position()
		idle_behaviour_time_secs = npc_data.idle_behaviour_time_secs
	
	idle_behaviour_time_secs -= delta
	
	if npc.global_position.distance_to(character_idle_target_position) >= 0.05:
		move_to_idle_target_position(delta)


func set_idle_target_position() -> void:
	character_idle_target_position.x = npc.global_position.x + randf_range(-npc_data.idle_movement_distance, npc_data.idle_movement_distance)
	character_idle_target_position.y = npc.global_position.y
	character_idle_target_position.z = npc.global_position.z + randf_range(-npc_data.idle_movement_distance, npc_data.idle_movement_distance)


func move_to_idle_target_position(delta) -> void:
	# Calculate the direction vector from the current position to the target position
	direction_to_idle_target = character_idle_target_position - npc.global_position
	# Normalize the direction to get a unit vector
	direction_to_idle_target = direction_to_idle_target.normalized()
	
	direction_to_idle_target.y = 0 - (gravity * delta)
	
	npc.velocity = direction_to_idle_target * npc_data.move_speed
	npc.move_and_slide()



#region Experimental
## Unfinished attempt to get monk animation to correspond with the direction
## it is moving during idle. Currently unconnected to rest of code.
func choose_animation_facing():
	var animation_name: String
	var angle_between_player_and_character_facing: float
	angle_between_player_and_character_facing = \
			rad_to_deg(player.global_position.angle_to(direction_to_idle_target))
	# Calculate the direction vector from the player to the character:
	
	var direction_to_character = (npc_data.global_position - player.global_position).normalized()

	angle_between_player_and_character_facing = rad_to_deg(direction_to_character.angle_to(direction_to_idle_target))

	if angle_between_player_and_character_facing < 0:
		angle_between_player_and_character_facing += 360  # Normalize the angle to be between 0 and 360 degrees

	if angle_between_player_and_character_facing < 22.5 \
			or angle_between_player_and_character_facing >= 337.5:
		animation_name = "move_back"
		animation.flip_h = false
		animation.play(animation_name)
		#print ("PC-npc angle = ", angle_between_player_and_character_facing, " ", animation_name)
		return
	elif angle_between_player_and_character_facing < 67.5:
		animation_name = "move_back_side"
		animation.flip_h = false
		animation.play(animation_name)
		#print ("PC-npc angle = ", angle_between_player_and_character_facing, " ", animation_name)
		return
	elif angle_between_player_and_character_facing < 112.5:
		animation_name = "move_side"
		animation.flip_h = false
		animation.play(animation_name)
		#print ("PC-npc angle = ", angle_between_player_and_character_facing, " ", animation_name)
		return
	elif angle_between_player_and_character_facing < 157.5:
		animation_name = "move_forward_side"
		animation.flip_h = false
		animation.play(animation_name)
		#print ("PC-npc angle = ", angle_between_player_and_character_facing, " ", animation_name)
		return
	elif angle_between_player_and_character_facing < 202.5:
		animation_name = "move_forward"
		animation.flip_h = false
		animation.play(animation_name)
		#print ("PC-npc angle = ", angle_between_player_and_character_facing, " ", animation_name)
		return
	elif angle_between_player_and_character_facing < 247.5:
		animation_name = "move_forward_side"
		animation.flip_h = true
		animation.play(animation_name)
		#print ("PC-npc angle = ", angle_between_player_and_character_facing, " ", animation_name, " flipped")
		return
	elif angle_between_player_and_character_facing < 292.5:
		animation_name = "move_side"
		animation.flip_h = true
		animation.play(animation_name)
		#print ("PC-npc angle = ", angle_between_player_and_character_facing, " ", animation_name, " flipped")
		return
	else:
		animation_name = "move_back_side"
		animation.flip_h = true
		animation.play(animation_name)
		#print ("PC-npc angle = ", angle_between_player_and_character_facing, " ", animation_name, " flipped")
		return
#endregion
