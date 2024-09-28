extends Resource
class_name PlayerInternalData


@export_group("Head bob")
@export_range(0.0, 4.0) var bob_frequency: float = 2.0:
  set(new_val):
    bob_frequency = clampf(new_val, 0.0, 4.0)
    emit_changed()
    return
  get():
    return bob_frequency
@export_range(0.0, 0.08) var bob_amplitude: float = 0.08:
  set(new_val):
    bob_amplitude = clampf(new_val, 0.0, 0.08)
    emit_changed()
    return
  get():
    return bob_amplitude

@export_group("Field of view (FOV)")
@export var base_fov: float = 75.0
@export var fov_change: float = 1.5
@export_range(0.0, 4.0) var fov_intensity: float = 1.0:
  set(new_val):
    fov_intensity = clampf(new_val, 0.0, 4.0)
    emit_changed()
    return
  get():
    return fov_intensity

@export var max_health: int = 100:
  set(new_val):
    max_health = clampi(max_health, new_val, (2 ** 31)-1) #AKA. sign 32 bit integer
    emit_changed()
    return
  get():
    return max_health

@export var health: int = 100:
  set(new_val):
    health = clampi(new_val, 0, max_health)
    emit_changed()
    return
  get():
    return health

var mouse_free: bool = false

