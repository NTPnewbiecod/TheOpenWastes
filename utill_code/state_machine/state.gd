extends Node
## [State] class prototype intended to use as a child of [StateMachine].
class_name State 

signal _sig_change_state(new_state: State)

## alias to normal [code]_ready[/code] function.
func ready() -> void:
	return

## call when enter this state.
func enter() -> void:
	return

## call when exit this state.
func exit() -> void:
	return


## alias to normal [code]_unhandled_input[/code] function.
## but only run when [StateMachine] select this state as current state.
@warning_ignore("unused_parameter")
func unhandled_input(event: InputEvent) -> void:
	return

## alias to normal [code]_process[/code] function.
## but only run when [StateMachine] select this state as current state.
@warning_ignore("unused_parameter")
func process(delta: float) -> void:
	return

## alias to normal [code]_physics_process[/code] function.
## but only run when [StateMachine] select this state as current state.
@warning_ignore("unused_parameter")
func physics_process(delta: float) -> void:
	return


func change_state(state_name: State) -> void:
	_sig_change_state.emit(state_name)
	return
