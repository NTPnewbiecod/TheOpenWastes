extends CharacterBody3D

@export var p_data: PlayerInternalData
@export var p_move_data: PlayerMovementData

@export_group("Nodes tree ref")
@export var head: Node3D
@export var camera: Camera3D

@onready var gravity: float = p_move_data.gravity

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	return

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and (Input.mouse_mode == Input.MOUSE_MODE_CAPTURED):
		head.rotate_y(-event.relative.x * ConfigFileHandler.mouse_settings['mouse_sensitivity'])
		var y_sensitivity
		if ConfigFileHandler.mouse_settings['invert_mouse']:
			y_sensitivity = -ConfigFileHandler.mouse_settings['mouse_sensitivity']
		else:
			y_sensitivity = ConfigFileHandler.mouse_settings['mouse_sensitivity']
		camera.rotate_x(-event.relative.y * y_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(60))
	return

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("free_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	return

func _process(_delta: float) -> void:
	return


class time_keeper:
	var acc_timer: float
	var deacc_time: float

var temp_var: float = 0.0
func _physics_process(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "backward", 0.1)
	var direction: Vector3 =  head.global_basis * Vector3(input_dir.x, 0, input_dir.y).normalized()
	movement(direction, delta)
	jump()
	gravity_force(delta)
	move_and_slide()
	# if velocity.length() < p_move_data.stop_velocity and not direction and is_on_floor():
	# 	velocity = Vector3.ZERO
	direction = Vector3.ZERO
	return


func gravity_force(delta: float):
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
	return

func jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += p_move_data.jump_velocity
	return

var force: Vector3 = Vector3.ZERO
func movement(in_direction: Vector3, delta: float):
	var friction_force: Callable = func () -> void:
		var normal_force: float = p_move_data.player_mass * -gravity
		force.move_toward(Vector3.ZERO, p_move_data.ground_friction_coeff * normal_force)
		return
	
	var air_drag: Callable = func () -> void:
		var drag_force: float = 0.5 * \
			p_move_data.air_density * \
			velocity.length() ** 2 \
			p_move_data.air_friction_coeff * \
			p_move_data.player_surface_area
