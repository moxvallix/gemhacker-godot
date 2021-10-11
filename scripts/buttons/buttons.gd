extends Node2D

export (String) var card

var enabled = true

# Called when the node enters the scene tree for the first time.
var state

func _ready():
	var root = get_tree().get_root()
	root.connect("state_broadcast", self, "_on_state_broadcast")

func _on_state_broadcast(broadcast_state):
	state = broadcast_state
	print(state)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	if enabled:
		get_parent().get_parent().get_node("grid").create_card(card)
