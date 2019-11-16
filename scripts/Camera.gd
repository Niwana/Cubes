extends Camera

var rot
var ROTATESPEED = 0.1
var MOVESPEED = 10
var INITIALMOVESPEED
var SPRINTSPEED = 5

var forward = false
var backward = false
var right = false
var left = false

func _ready():
	INITIALMOVESPEED = MOVESPEED

func _process(delta):
	if forward:
		global_translate(-global_transform.basis.z * MOVESPEED  * delta)
	if backward:
		global_translate(global_transform.basis.z * MOVESPEED  * delta)
	if right:
		global_translate(global_transform.basis.x * MOVESPEED  * delta)
	if left:
		global_translate(-global_transform.basis.x * MOVESPEED  * delta)

func _input(event):
	# Rotate the camera
	if Input.is_action_pressed("camera_rotate"):
		if event is InputEventMouseMotion:
			rotation.x = (rotation.x - event.relative.y * ROTATESPEED  * get_process_delta_time())
			rotation.y = (rotation.y - event.relative.x * ROTATESPEED  * get_process_delta_time())
		
		# Move the camera
		if event is InputEventKey:
			if Input.is_action_pressed("camera_move_forward"):
				forward = true
			if Input.is_action_just_released("camera_move_forward"):
				forward = false
				
			if Input.is_action_pressed("camera_move_backward"):
				backward = true
			if Input.is_action_just_released("camera_move_backward"):
				backward = false
				
			if Input.is_action_pressed("camera_move_right"):
				right = true
			if Input.is_action_just_released("camera_move_right"):
				right = false
				
			if Input.is_action_pressed("camera_move_left"):
				left = true
			if Input.is_action_just_released("camera_move_left"):
				left = false

			if Input.is_action_just_pressed("sprint"):
				MOVESPEED *= SPRINTSPEED
			if Input.is_action_just_released("sprint"):
				MOVESPEED = INITIALMOVESPEED
	else:
		ResetValues()


func ResetValues():
	MOVESPEED = INITIALMOVESPEED
	forward = false
	backward = false
	right = false
	left = false
