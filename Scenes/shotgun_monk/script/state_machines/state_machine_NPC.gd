extends StateMachine

@warning_ignore('unused_parameter')
func debug_physics_process(delta: float) -> void:
  print(_current_state.name)
  return