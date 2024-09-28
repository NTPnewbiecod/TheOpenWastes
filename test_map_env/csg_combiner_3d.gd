extends CSGCombiner3D

@export var collision_shape: CollisionShape3D

func _physics_process(delta: float) -> void:
	if Engine.get_physics_frames() == 10:
		var mesh: PackedVector3Array = get_meshes()[1].get_faces()
		var shape: ConcavePolygonShape3D = ConcavePolygonShape3D.new()
		shape.call("set_faces", mesh)
		collision_shape.shape = shape
