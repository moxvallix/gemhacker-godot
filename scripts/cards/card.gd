extends Node2D

export (String) var card
export (String, "plain", "action", "single", "double") var card_type

var move_tween
var move_speed = 0.15

var material_1_scene = preload("res://scenes/materials/material.tscn")
var material_2_scene = preload("res://scenes/materials/material.tscn")

var material_1
var material_2

var asset_scale = Vector2(5,5)

var material_1_pos = Vector2(40, 2) * asset_scale
var material_2_pos = Vector2(4,2) * asset_scale

var global
var state

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/Global")	
	move_tween = get_node("move_tween")
	if card_type == "single":
		add_material(material_1_scene.instance(), material_1_pos)
	if card_type == "double":
		add_material(material_1_scene.instance(), material_1_pos)
		add_material(material_2_scene.instance(), material_2_pos)

func add_material(material, position):
	add_child(material)
	material.position = position

func move(target):
	move_tween.interpolate_property(self, "position", position, target, move_speed, Tween.TRANS_SINE, Tween.EASE_OUT);
	move_tween.start();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	state = global.state
	material_1 = material_1_scene.instance().material_id
	material_2 = material_2_scene.instance().material_id
