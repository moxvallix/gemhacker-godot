extends Node2D

export (String) var card

var enabled = true
var state
# Called when the node enters the scene tree for the first time.
var global

func _ready():
	global = get_node("/root/Global")
	state = global.state
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	state = global.state
	if enabled:
		self.modulate = Color(1, 1, 1)
	if !enabled:
		self.modulate = Color(0.3, 0.3, 0.3)

func _on_button_mouse_entered():
	if state != "running":
		if enabled:
			var button = get_node("button")
			button.modulate = Color(0, 0.95, 0)

func _on_button_mouse_exited():
	var button = get_node("button")
	button.modulate = Color(1, 1, 1)

func _on_button_pressed():
	if state != "running":
		if enabled:
			get_parent().get_parent().get_node("grid").create_card(card)
