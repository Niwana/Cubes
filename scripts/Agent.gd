extends RigidBody

onready var navigation : Navigation = get_node("../../Navigation")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var target = Vector3(30,10,30);

var path = []

var counter = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body..	
	
func update_path(target):
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
	return Vector3((randi() % 100) - 50 , 0, (randi() % 100) - 50)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(path.size() == 0):
		update_path(generate_target());
		draw_path();
		
	counter = counter + delta
	if(counter > 0.5):
		counter = 0
		if(path.size() > 0):
			path.remove(0)
		draw_path()
	
	#var basis = global_transform.basis.x
	#add_central_force(basis*10);
	#add_torque(Vector3(0,1,0));
	
