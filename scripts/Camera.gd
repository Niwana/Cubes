extends Camera

var rot
var ROTATESPEED = 0.005
var MOVESPEED = 0.2
var MOVESPEEDSPRINT = 5


func _input(event):
	
	# Rotate the camera
	if Input.is_action_pressed("camera_rotate"):
		if event is InputEventMouseMotion:
			rotation.x = (rotation.x - event.relative.y * ROTATESPEED)
			rotation.y = (rotation.y - event.relative.x * ROTATESPEED)
		
		# Move the camera
		if event is InputEventKey:
			if Input.is_action_pressed("camera_move_forward"):
				if Input.is_action_pressed("sprint"):
					global_translate(-global_transform.basis.z * MOVESPEED * MOVESPEEDSPRINT)
				else:
					global_translate(-global_transform.basis.z * MOVESPEED)
					
			if Input.is_action_pressed("camera_move_backward"):
				if Input.is_action_pressed("sprint"):
					global_translate(global_transform.basis.z * MOVESPEED * MOVESPEEDSPRINT)
				else:
					global_translate(global_transform.basis.z * MOVESPEED)

			if Input.is_action_pressed("camera_move_right"):
				if Input.is_action_pressed("sprint"):
					global_translate(global_transform.basis.x * MOVESPEED * MOVESPEEDSPRINT)
				else:
					global_translate(global_transform.basis.x * MOVESPEED)
					
			if Input.is_action_pressed("camera_move_left"):
				if Input.is_action_pressed("sprint"):
					global_translate(-global_transform.basis.x * MOVESPEED * MOVESPEEDSPRINT)
				else:
					global_translate(-global_transform.basis.x * MOVESPEED)
