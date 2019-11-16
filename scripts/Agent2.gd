extends KinematicBody

onready var navigation : Navigation = get_node("../../Navigation")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var checkpoint = null

var path = []

var counter = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	get_next_checkpoint()
	pass # Replace with function body..	
	
func update_path(target):
	print("GETTING PATH")
	path = navigation.get_simple_path(global_transform.origin, target)
	get_next_checkpoint()
		
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
	var target = Vector3((randi() % 100) - 50 , 0, (randi() % 100) - 50)
	return target
	
func get_next_checkpoint():
	if(path.size() > 0):
		checkpoint = path[0]
		path.remove(0)
	else:
		update_path(generate_target());

func _process(delta):
	draw_path();
	if(checkpoint != null):
		
		var directionTo = global_transform.origin.direction_to(checkpoint)
		directionTo.y = 0
		directionTo = directionTo.normalized()
		move_and_slide(directionTo*10)
		
		var dist = (checkpoint - global_transform.origin)
		dist.y = 0
		if dist.length() > 0.1:
			pass
		else:
			get_next_checkpoint();
		
		look_at(directionTo+global_transform.origin, Vector3(0,1,0))
	
	
