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

func _physics_process(_delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("left", "right", "forward", "backward", 0.1)
	var direction: Vector3 =  head.global_basis * Vector3(input_dir.x, 0, input_dir.y)
	movement(direction)
	jump()
	gravity_force()
	force = Vector3.ZERO
	move_and_slide()
	print(velocity.length())
	for i in get_slide_collision_count() -1:
			var physic_mat: PhysicsMaterial = get_slide_collision(i).get_collider().call("get_physics_material_override")
			if physic_mat != null:
				p_move_data.ground_friction_coeff = physic_mat.friction
	return


func gravity_force():
	if not is_on_floor():
		velocity.y -= gravity * get_physics_process_delta_time()
	return

func jump() -> void:
	if (Input.is_action_just_pressed("jump") or Input.is_action_pressed("jump")) and is_on_floor():
		velocity.y = (gravity / 2) * p_move_data.jump_velocity
	return

var force: Vector3 = Vector3.ZERO
func movement(wish_direction: Vector3):

	var accelerate: Callable = func (acc: float, soft_speed_limit: float) -> void:
		var cur_speed_in_wish_dir: float = self.velocity.dot(wish_direction)
		var add_speed_till_cap: float = soft_speed_limit - cur_speed_in_wish_dir
		if add_speed_till_cap > 0:
			var accel_speed: float = acc * soft_speed_limit * get_physics_process_delta_time()
			accel_speed = min(accel_speed, accel_speed * add_speed_till_cap)
			velocity += accel_speed * wish_direction
		

		# force += acc * p_move_data.player_mass * in_direction * p_move_data.ground_friction_coeff
		return
	
	if Input.is_action_pressed("sprint"):
		if wish_direction and is_on_floor():
			accelerate.call(p_move_data.sprint_acc, p_move_data.sprint_speed)
		elif wish_direction and not is_on_floor():
			accelerate.call(p_move_data.sprint_acc * p_move_data.air_sprint_mul, p_move_data.air_strafe_speed_soft_limit)
	else:
		if wish_direction and is_on_floor():
			accelerate.call(p_move_data.walk_acc, p_move_data.walk_speed)
		elif wish_direction and not is_on_floor():
			accelerate.call(p_move_data.walk_acc * p_move_data.air_walk_mul, p_move_data.air_strafe_speed_soft_limit)

	var friction_force: Callable = func () -> void: # absolute dry kinetic friction force
		var normal_force: float =  gravity # assume normal force is always perpendicular to the floor.
		var over_velocity_deacc_fac: float = 1
		if Vector2(velocity.x, velocity.x).length() > p_move_data.sprint_speed: # to deccelerate faster when moving very fast.
			over_velocity_deacc_fac = Vector2(velocity.x, velocity.x).length()
		var subtracted_velocity: float = velocity.length() - p_move_data.ground_friction_coeff * normal_force * over_velocity_deacc_fac * get_physics_process_delta_time()
		if subtracted_velocity > 0:
			var new_velocity_ratio: float = subtracted_velocity / velocity.length()
			velocity *= new_velocity_ratio
		else:
			velocity *= 0.5 # get rid of that minuscule left over velocity

	var aero_drag: Callable = func () -> void:
		var drag_force = 0.5 * p_move_data.air_density * velocity.length() ** 2 * p_move_data.air_friction_coeff * p_move_data.player_surface_area
		velocity -= velocity.normalized() * (drag_force / p_move_data.player_mass) * get_physics_process_delta_time()

	if is_on_floor():
		friction_force.call()
	elif velocity.length() > 10 and not is_on_floor_only():
		aero_drag.call()
