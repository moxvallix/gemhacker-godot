extends Node2D

export (String) var card

var enabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_mouse_entered():
	var button = get_node("button")
	button.modulate = Color(0, 0.95, 0)


func _on_button_mouse_exited():
	var button = get_node("button")
	button.modulate = Color(1, 1, 1)

func _on_button_pressed():
	get_parent().get_parent().get_node("grid").create_card(card)
