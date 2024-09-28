
## State Machine manager
## it doesn't do any thing on there own.
## ment to use with [State] node
class_name StateMachine extends Node

@export var init_state: State

var _current_state: State = null

func _on_sig_change_state(new_state: State) -> void:
	_current_state.exit()
	_current_state = new_state
	_current_state.enter()
	return

func _ready() -> void:
	var childs_node: Array = get_children(false)
	# var childs = childs_node.filter(func (i: Node): if i.is_ancestor_of(): return i)
	for i in childs_node:
		i.ready()
		i._sig_change_state.connect(_on_sig_change_state)
		_current_state = init_state
	
	if init_state == null:
		var err_msg: String = "unassign initial State for StateMachine"
		printerr(err_msg)
		assert(false, err_msg)
	return

func _unhandled_input(event: InputEvent) -> void:
	if _current_state.has_method('unhandled_input'):
		_current_state.unhandled_input(event)
	return

func _process(delta: float) -> void:
	if _current_state.has_method('process'):
		_current_state.process(delta)
	return

func _physics_process(delta: float) -> void:
	if _current_state.has_method('physics_process'):
		_current_state.physics_process(delta)
	return
