extends Node2D

var global
var state

signal running

var stop_texture = preload("res://assets/ui/stop.png")
var run_texture = preload("res://assets/ui/run.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/Global")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	state = global.state
	if state == "running":
		get_node("TextureButton").set_normal_texture(stop_texture)
	else:
		get_node("TextureButton").set_normal_texture(run_texture)

func _on_TextureButton_pressed():
	if state != "running":
		global.state = "running"
		emit_signal("running")
	elif state == "running":
		global.state = "none"

func _on_TextureButton_mouse_entered():
	var button = get_node("TextureButton")
	if state == "running":
		button.modulate = Color(0.75, 0, 0)
	else:
		button.modulate = Color(0, 0.95, 0)


func _on_TextureButton_mouse_exited():
	var button = get_node("TextureButton")
	button.modulate = Color(1, 1, 1)
