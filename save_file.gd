extends Node

#Saving and loading user settings

const SAVE_FILE = "user://save_file.save"
var game_data = {}

func _ready():
	load_data()
	print(game_data)
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(game_data.sound_level))
	AudioServer.set_bus_mute(music_bus, game_data.toggled_sound)
	
	var SFX_bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(SFX_bus, linear_to_db(game_data.sfx_level))
	AudioServer.set_bus_mute(SFX_bus, game_data.toggledSFX)
	
	if game_data.full_screen==true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
func save_data():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_var(game_data)
	file.close()
	
func load_data():
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	if not file:
		game_data = {
			"username" : "Username",
			"sound_level" : 1,
			"toggled_sound" : false,
			"full_screen" : false,
			"sfx_level" : 1,
			"toggledSFX" : false,
			"server" : "sly.uglu.ch"
		}
		save_data()
	file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	game_data = file.get_var()
	file.close()
