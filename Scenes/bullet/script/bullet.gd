class_name Projectile extends Node3D

## this value are ment to be change by the code.
var muzzle_velocity: float = 100
## this value are ment to be change by the code.
var damage: float = 10
## this value are ment to be change by the code.
var life_time: float = 10

@onready var life_time_timer: Timer = $LifeTimeTimer

func _ready() -> void:
	$Hazard.damage = damage
	return

func _physics_process(delta: float) -> void:
	top_level = true
	$Hazard.monitoring = true
	position += transform.basis * Vector3(0, 0, -muzzle_velocity) * delta
	if life_time_timer.time_left == 0.0:
		life_time_timer.start(life_time)
	return


func _on_timer_timeout() -> void:
	queue_free()
	return
