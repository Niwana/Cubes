extends Node

var Ground = preload("res://Scenes/Ground.tscn")
export var MAPSIZE = 4
var blocks = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range (MAPSIZE):
		#randomize() # Randomize a seed for randf()
		#var color = Color(randf(), randf(), randf())
		for j in range (MAPSIZE):
			var block = Ground.instance()
			blocks.append(block)
			add_child(block)
			block.set_translation(Vector3(block.get_scale().x*2*i, 0, block.get_scale().x*2*j))
			#blocks[i].get_node("MeshInstance").get_surface_material(0).albedo_color = color
			#print(color)
