extends Node2D

@onready var tile_map = $TileMap

@export var PlayerScene : PackedScene

var ground_layer = 0

var source_id = 0

var button = false

var bloc_coord = Vector2i(12,9)

var tile_map_pos = Vector2i(0,0)

func _ready():
	var index = 0
	for i in GameManager.Players:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(GameManager.Players[i].id)
		add_child(currentPlayer)
		for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
		index += 1
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
		
		if (mouse_pos.y <= 512):
		
			tile_map_pos = tile_map.local_to_map(mouse_pos)
			
			if (bloc_coord == Vector2i(99,99)):
				rpc("rpc_erase", ground_layer, tile_map_pos)
			else:
				rpc("rpc_place", ground_layer, tile_map_pos, source_id, bloc_coord)

@rpc("any_peer", "call_local")
func rpc_erase(layer, pos):
	tile_map.erase_cell(layer, pos)

@rpc("any_peer", "call_local")
func rpc_place(layer, pos, id, coord):
	tile_map.set_cell(layer, pos, id, coord)
