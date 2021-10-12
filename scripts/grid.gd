extends Node2D

export (float) var imgscale

export (int) var width
export (int) var height
export (int) var x_offset
export (int) var y_offset
export (int) var x_start
export (int) var y_start

var exit_loop

signal card_created(card)
signal card_destroyed(card)

var trash_zone = Vector2(-1, 6)

var shifting = false
var delete_ready = false

var click_pos
var dragging = false
var being_dragged
var mouse_pos
var initial_pos

var board = []
var possible_cards = [
	preload("res://scenes/cards/input_card.tscn"),
	preload("res://scenes/cards/craft_card.tscn"),
	preload("res://scenes/cards/discard_card.tscn"),
	preload("res://scenes/cards/if_card.tscn"),
	preload("res://scenes/cards/or_card.tscn"),
	preload("res://scenes/cards/not_card.tscn"),
	preload("res://scenes/cards/max_card.tscn"),
	preload("res://scenes/cards/lift_card.tscn"),
	preload("res://scenes/cards/pipe_card.tscn"),
	preload("res://scenes/cards/jump_card.tscn"),
]

var global
var state

# Called when the node enters the scene tree for the first time.
func _ready():
	global = get_node("/root/Global")
	state = global.state
	board = make_2d_array()
	OS.set_window_maximized(true)
#	spawn_pieces()

func create_card(card):
	for loop in possible_cards.size():
		var current_card = possible_cards[loop].instance()
		if current_card.card == card:
			spawn_card(current_card)
			emit_signal("card_created", current_card)

func make_2d_array():
	var array = []
	for col in width:
		array.append([])
		for row in height:
			array[col].append(null)
	return array

func spawn_card(card): 
	for col in width:
		for row in height:
			if board[col][row] == null:
				add_child(card)
				card.position = grid_to_pixel(col, row)
				board[col][row] = card
				exit_loop = true
				break
		if exit_loop == true:
			exit_loop = false
			break

func grid_to_pixel(col, row):
	var new_x = (x_start * imgscale) + x_offset * col * imgscale
	var new_y = (y_start * imgscale) + y_offset * row * imgscale
	return Vector2(new_x, new_y)

func pixel_to_grid(position):
	var new_x = floor((position.x - (x_start * imgscale)) / x_offset / imgscale)
	var new_y = floor((position.y - (y_start * imgscale)) / y_offset / imgscale)
	return Vector2(new_x, new_y)

func touch_input():
	if Input.is_action_just_pressed("ui_touch"):
		if dragging == false:
			mouse_pos = get_global_mouse_position()
			click_pos = pixel_to_grid(mouse_pos)
			initial_pos = grid_to_pixel(click_pos.x, click_pos.y)
			var current_tile = board[click_pos.x][click_pos.y]
			if current_tile != null:
				dragging = true
				being_dragged = current_tile
				board[click_pos.x][click_pos.y] = null
			if click_pos == trash_zone && shifting == true:
				for object in get_node(".").get_children():
					emit_signal("card_destroyed", object)
					get_node(".").remove_child(object)
					object.queue_free()
				board = make_2d_array()

	if Input.is_action_just_released("ui_touch"):
		if dragging:
			drop(being_dragged)

func key_input():
	if Input.is_action_just_pressed("ui_shift"):
		shifting = true
	if Input.is_action_just_released("ui_shift"):
		shifting = false

func misc():
	var mouse_in_grid = pixel_to_grid(get_global_mouse_position())
	if mouse_in_grid == trash_zone && shifting == true:
		for n in get_node(".").get_children():
			delete_ready = true
			n.modulate = Color(0.75, 0, 0)
	elif (shifting == false || mouse_in_grid != trash_zone) && delete_ready == true:
		for n in get_node(".").get_children():
			n.modulate = Color(1, 1, 1)

func drag(object):
	object.position = get_global_mouse_position() - (mouse_pos - initial_pos)
	object.z_index = 1000
	var mouse_in_grid = pixel_to_grid(get_global_mouse_position())
	if mouse_in_grid == trash_zone:
		object.modulate = Color(0.75, 0, 0)
	else:
		object.modulate = Color(1, 1, 1)

func drop(object):
	var grid_pos = pixel_to_grid(get_global_mouse_position())
	if is_in_grid(grid_pos):
		var board_pos = board[grid_pos.x][grid_pos.y]
		if board_pos == null:
			board[grid_pos.x][grid_pos.y] = object
			object.move(grid_to_pixel(grid_pos.x, grid_pos.y))
			dragging = false
			object.z_index = 1
		if board_pos != null:
			send_back(object)
	elif grid_pos == trash_zone:
		dragging = false
		emit_signal("card_destroyed", object)
		object.queue_free()
	else:
		send_back(object)

func send_back(object):
	dragging = false
	object.move(initial_pos)
	board[click_pos.x][click_pos.y] = object
	object.z_index = 1

func is_in_grid(pos):
	if pos.x >= 0 && pos.x < width:
		if pos.y >= 0 && pos.y < height:
			return true
	return false

func _process(_delta):
	state = global.state
	if state != "running":
		touch_input()
		key_input()
		misc()
		if dragging:
			drag(being_dragged)
