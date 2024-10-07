extends Control


@export var health_component_ref: Health
@onready var health_counter: Label = $HealthCounter
func _ready() -> void:
	health_counter.text = str(health_component_ref.health)
	return

func _process(_delta: float) -> void:
	health_counter.text = str(health_component_ref.health)
	return
