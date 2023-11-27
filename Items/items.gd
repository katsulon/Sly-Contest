extends Node2D

func _mouse_enter():
	if Input.is_action_pressed("click"):
		queue_free()
