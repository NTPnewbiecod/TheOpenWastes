extends Node
class_name State 
## [State] class prototype intended to use as a child of [StateMachine].[br]
## Note: by default these following Built-in function are disable.[br]
## _process[br]
## _physics_process[br]
## _process_unhandled_input[br]
## if you want to enable them call these following function with these argument.[br]
## set_process(true)[br]
## set_physics_process(true)[br]
## set_process_unhandled_input(true)[br][br]
## see [url]https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-set-process[\url][br]
## see [url]https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-set-physics-process[\url][br]
## see [url]https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-set-process-unhandled-input[\url][br]
## for more info.

signal _sig_change_state(new_state: State)
var _state_mechine_parent: StateMachine

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
	if get_parent() is StateMachine:
		_state_mechine_parent = get_parent()
	else:
		var err_text: String = error_string(ERR_BUG)
		assert(false, err_text + "\nState class node is not a direct child of StateMechine")
	return

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
