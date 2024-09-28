extends Node


func print_every_few_tick(args: Array = [], ratio: float = 0.5,) -> void:
	if fmod(Engine.get_physics_frames(), (Engine.physics_ticks_per_second * ratio)) <= 1.0:
		print(args)
	return