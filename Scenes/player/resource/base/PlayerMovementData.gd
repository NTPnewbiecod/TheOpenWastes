extends Resource
class_name PlayerMovementData

@export_group("On Ground")
@export var player_mass: float = 50
@export var player_surface_area: float = 0.4
@export var jump_velocity: float = 1
@export_subgroup("walk")
@export var walk_speed: float = 4
@export var walk_acc: float = 6.5
@export_subgroup("sprint")
@export var sprint_speed: float = 6
@export var sprint_acc: float = 15
@export_subgroup("ground friction")
@export var ground_friction_coeff: float = 0.9
@export_subgroup("air friction")
@export var air_friction_coeff: float = 0.7
@export var air_density: float = 1.2

@export_group("air strafe")
@export var air_walk_mul: float = 0.1
@export var air_sprint_mul: float = 0.1
@export var air_strafe_speed_soft_limit: float = 10

var gravity: float = ProjectSettings.get("physics/3d/default_gravity"):
  set(new_val):
    gravity = new_val
    emit_changed()
    return
  get():
    return gravity
