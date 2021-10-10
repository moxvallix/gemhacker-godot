extends Node2D

var material_id = 4

var materials = [
	preload("res://scenes/materials/red_material.tscn"),
	preload("res://scenes/materials/yellow_material.tscn"),
	preload("res://scenes/materials/green_material.tscn"),
	preload("res://scenes/materials/blue_material.tscn"),
	preload("res://scenes/materials/purple_material.tscn"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	update_materials()
	pass # Replace with function body.

func on_click():
	if material_id < materials.size():
		pass

func update_materials():
	delete_children()
	add_child(materials[material_id].instance())
	
func delete_children():
	for n in get_node(".").get_children():
		get_node(".").remove_child(n)
		n.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if get_global_mouse_position() == 
