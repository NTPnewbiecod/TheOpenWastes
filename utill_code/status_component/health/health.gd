extends Node
class_name Health

@export var health: float = 100:
	set(new_val):
		health = maxf(new_val, 0)
		return

@export var max_health: float = 100:
	set(new_val):
			health = maxf(new_val, 0)
			return

func set_health(new_val: float) -> void:
	health = maxf(new_val, 0)
	return