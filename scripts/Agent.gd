extends RigidBody

onready var navigation : Navigation = get_node("../../Navigation")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var target = Vector3(30,10,30);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body..	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var path = navigation.get_simple_path(global_transform.origin, target)
	var first = path[0]
	var last = first
	for p in path:
		if(p == first):
			pass
		else:
			DrawLine3D.DrawLine(last, p, 100, 1)
			last = p
	#var basis = global_transform.basis.x
	#add_central_force(basis*10);
	#add_torque(Vector3(0,1,0));
	
