extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var state

func _ready():
	var root = get_tree().get_root()
	root.connect("state_broadcast", self, "_on_state_broadcast")

func _on_state_broadcast(broadcast_state):
	state = broadcast_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_grid_card_created(card):
	if card.card_type == "action":
		set_card_enabled(card, false)

func _on_grid_card_destroyed(card):
	if card.card_type == "action":
		set_card_enabled(card, true)

func set_card_enabled(card, value):
	var card_id = card.card
	for button in self.get_children():
		if button.card == card_id:
			button.enabled = value
			break
