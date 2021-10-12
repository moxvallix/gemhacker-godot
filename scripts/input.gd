extends Node2D

export (int) var width
export (int) var texture_width
export (int) var texture_scale

export (int) var x_offset
export (int) var y_offset

signal run_input(texture, input)

var global
var input

var input_row = []

var materials = [
	[preload("res://assets/materials/ruby.png"), "red"],
	[preload("res://assets/materials/topaz.png"), "yellow"],
	[preload("res://assets/materials/emerald.png"), "green"],
	[preload("res://assets/materials/sapphire.png"), "blue"],
	[preload("res://assets/materials/amythest.png"), "purple"],
]

var input_scene = preload("res://scenes/materials/input.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/Global")
	input = global.input
	input_row = make_2d_array()
	gen_material()
	spawn_material()

func make_2d_array():
	var array = []
	for col in width:
		array.append([])
		for row in materials[0].size():
			array[col].append(null)
	return array

func gen_material():
	var position = 0
	for gem in input:
		for mat in materials:
			if gem == mat[1]:
				input_row[position] = mat
		position += 1

func spawn_material():
	var position = 0
	for gem in input_row:
		var gem_scene = input_scene.instance()
		add_child(gem_scene)
		gem_scene.get_child(0).set_texture(gem[0])
		gem_scene.input = gem[1]
		gem_scene.position = Vector2(pos_to_pixel(position), (y_offset * texture_scale))
		position += 1

func run_input():
	var input_round = global.input_round
	var texture = input_row[input_round][0]
	var type = input_row[input_round][1]
	emit_signal(texture, type)

func pos_to_pixel(pos):
	var x = (pos * texture_width * texture_scale) - (x_offset * texture_scale)
	return x
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
