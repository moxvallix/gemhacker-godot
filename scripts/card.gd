extends Node2D

export (String) var card
export (String, "none", "single", "double") var materials

var material_1 = preload("res://scenes/materials/material.tscn")
var material_2 = preload("res://scenes/materials/material.tscn")

var asset_scale = Vector2(5,5)

var material_1_pos = Vector2(40, 2) * asset_scale
var material_2_pos = Vector2(4,2) * asset_scale

# Called when the node enters the scene tree for the first time.
func _ready():
	print(scale)
	if materials == "single":
		add_material(material_1.instance(), material_1_pos)
	if materials == "double":
		add_material(material_1.instance(), material_1_pos)
		add_material(material_2.instance(), material_2_pos)
	pass # Replace with function body.

func add_material(material, position):
	add_child(material)
	material.position = position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
