extends RigidBody

onready var navigation : Navigation = get_node("../../Navigation")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var checkpoint = null

var path = []

var counter = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body..	
	
func update_path(target):
	print("GETTING PATH")
	path = navigation.get_simple_path(global_transform.origin, target)
	
func draw_path():
	if(path.size() > 0):
		var first = path[0]
		var last = first
		for p in path:
			if(p == first):
				pass
			else:
				DrawLine3D.DrawLine(last, p, Color(1, 1, 0.5), 1)
				last = p
	
func generate_target():
	print("GENERATING TARGET")
	var target = Vector3((randi() % 100) - 50 , 0, (randi() % 100) - 50)
	return target
	
func get_next_checkpoint():
	if(path.size() > 0):
		checkpoint = path[0]
		path.remove(0)
	else:
		checkpoint = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(path.size() == 0):
		update_path(generate_target());
		get_next_checkpoint()
		
	draw_path();
	print(checkpoint)
	if(checkpoint != null):
		var dist = (checkpoint - global_transform.origin)
		if dist.length() > 4:
			add_central_force(global_transform.basis.x * 20)
		else:
			get_next_checkpoint();
		
func look_follow(state, current_transform, target_position):
	var up_dir = Vector3(0, 1, 0)
	var cur_dir = current_transform.basis.xform(Vector3(1, 0, 0))
	var target_dir = (target_position - current_transform.origin).normalized()
	var rotation_angle = 0
	if(target_dir.z < 0):
		rotation_angle = acos(target_dir.x) - acos(cur_dir.x) 
	else:
		rotation_angle = acos(cur_dir.x) - acos(target_dir.x) 
	var clamped_angle = clamp(rotation_angle, -0.05, 0.05)

	state.set_angular_velocity(up_dir * (clamped_angle / state.get_step()))

func _integrate_forces(state):
	if(checkpoint != null):
		var target_position = checkpoint
		look_follow(state, get_global_transform(), target_position)
	
