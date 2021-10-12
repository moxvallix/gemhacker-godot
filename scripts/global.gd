extends Node

var state

var input = ["red", "red", "blue", "green", "green", "yellow", "blue", "purple", "purple"]
var input_round = 0

var recipe_1 = ["red", 2]
var recipe_2 = ["green", 1]
var recipe_3 = []

# Called when the node enters the scene tree for the first time.
func _ready():
	state = "none"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state != "running":
		input_round = 0
