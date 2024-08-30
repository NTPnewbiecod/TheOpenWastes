extends Camera3D

## ShitCo burner code, just to get a port-a-camera into the scene
## that can be moved around a bit.
## It's more to be pitied than scorned!

var distance: float = 1.0
var rotation_rate: float = 0.2

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_A):
		position.x += distance
	if Input.is_key_pressed(KEY_D):
		position.x -= distance
	if Input.is_key_pressed(KEY_W):
		position.z += distance
	if Input.is_key_pressed(KEY_S):
		position.z -= distance
	if Input.is_key_pressed(KEY_Q):
		rotation.x += rotation_rate
	if Input.is_key_pressed(KEY_E):
		rotation.x -= rotation_rate
	
	if Input.is_key_pressed(KEY_UP):
		position.y += distance
	if Input.is_key_pressed(KEY_DOWN):
		position.y -= distance
	if Input.is_key_pressed(KEY_LEFT):
		rotation.y += rotation_rate
	if Input.is_key_pressed(KEY_RIGHT):
		rotation.y -= rotation_rate
	
