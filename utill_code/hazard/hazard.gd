extends Area3D
class_name Hazard


var damage: float = 10

func _on_area_entered(area:Area3D) -> void:
  for i in area.get_children(true):
    if i is Health:
      i.set_health(i.health - damage)
    else:
      get_parent().queue_free()
  return
