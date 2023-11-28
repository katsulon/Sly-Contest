extends Node2D

@export var this_scene : PackedScene
@onready var object_cursor = get_node("/root/Level")
@onready var cursor_sprite = object_cursor.get_node("Sprite")

var inside = false

func _mouse_enter():
	inside = true

func _mouse_exit():
	inside = false

func _input(event):
	var bloc_coord = get_node("/root/Level").bloc_coord
	var erase_text = get_node("/root/Level").erase_text
	
	if Input.is_action_pressed("click") and inside:
		if (bloc_coord == erase_text):
			queue_free()
