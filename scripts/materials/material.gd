extends Node2D

var material_id = 0

var materials = [
	preload("res://assets/materials/ruby.png"),
	preload("res://assets/materials/topaz.png"),
	preload("res://assets/materials/emerald.png"),
	preload("res://assets/materials/sapphire.png"),
	preload("res://assets/materials/amythest.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	update_materials()
	pass # Replace with function body.

func on_click():
	if material_id == materials.size() - 1:
		material_id = 0
		update_materials()
	elif material_id < materials.size() - 1:
		material_id += 1
		update_materials()

func update_materials():
	get_node("TextureButton").set_normal_texture(materials[material_id])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TextureButton_pressed():
	on_click()
