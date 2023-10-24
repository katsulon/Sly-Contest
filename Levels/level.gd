extends Node2D

@onready var tile_map = $TileMap

var ground_layer = 0

var source_id = 0

var button = false

var bloc_coord = Vector2i(12,9)

var tile_map_pos = Vector2i(0,0)

func _ready():
	pass

func _on_button_pressed():
	bloc_coord = Vector2i(12,9)
	
func _on_button_2_pressed():
	bloc_coord = Vector2i(17,9)
	
func _on_button_3_pressed():
	bloc_coord = Vector2i(99,99)

func _input(event):
	if Input.is_action_just_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		
		if (mouse_pos.y <= 257):
		
			tile_map_pos = tile_map.local_to_map(mouse_pos)
			
			if (bloc_coord == Vector2i(99,99)):
				tile_map.erase_cell(ground_layer, tile_map_pos)
			else:
				tile_map.set_cell(ground_layer, tile_map_pos, source_id, bloc_coord)
