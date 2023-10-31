extends Node2D

@onready var tile_map = $TileMap

@export var PlayerScene : PackedScene

var ground_layer = 0

var source_id = 0

var button = false

var bloc_coord = Vector2i(12,9)

var tile_map_pos = Vector2i(0,0)

var x1Min = 1
var x1Max = 29
var yMin = 2
var yMax = 30
var x2Min = x1Min + 31
var x2Max = x1Max + 31

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

func blocgen2x2(ULx,ULy,TMx,TMy):
	tile_map.set_cell(ground_layer, Vector2i(ULx,ULy), source_id, Vector2i(TMx,TMy))
	tile_map.set_cell(ground_layer, Vector2i(ULx+1,ULy), source_id, Vector2i(TMx+2,TMy))
	tile_map.set_cell(ground_layer, Vector2i(ULx,ULy+1), source_id, Vector2i(TMx,TMy+2))
	tile_map.set_cell(ground_layer, Vector2i(ULx+1,ULy+1), source_id, Vector2i(TMx+2,TMy+2))
	
func finish_coord(coord,padding,min_coord,max_coord,uppergap=0):
	var rand1 = randi_range(min_coord,coord-(2+padding+uppergap))
	var rand2 = randi_range(coord+(2+padding+uppergap),max_coord)
	
	if coord >= (min_coord+(2+padding+uppergap)) && coord <= (max_coord-(2+padding+uppergap)):
		if randi_range(0,1):
			return rand1
		else:
			return rand2
	elif coord > max_coord-(2+padding+uppergap):
		return rand1
	else:
		return rand2
	
func start_finish():
	var padding = 8
	var startx = randi_range(x1Min,x1Max)
	var starty = randi_range(yMin,yMax)
	var endx = randi_range(x1Min,x1Max)
	var endy = randi_range(yMin,yMax)
	# endx = finish_coord(startx,8,1,29)
	if endx > startx-(padding+2) && endx < startx+(padding+2):
		endy = finish_coord(starty,padding,yMin,yMax,2)
	
	blocgen2x2(startx,starty,6,0)
	blocgen2x2(endx,endy,6,8)
	blocgen2x2(startx+31,starty,6,0)
	blocgen2x2(endx+31,endy,6,8)
	
	var start_pos = Vector2i(startx,starty-1)
	start_pos = tile_map.map_to_local(start_pos)
	start_pos.x += 8
	
	return start_pos

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
