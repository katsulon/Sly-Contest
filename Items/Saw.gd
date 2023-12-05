extends "res://Items/items.gd"

func _ready():
	get_node("Sprite").play("on")

func _on_body_entered(body):
	if body.has_method("kill"):
		body.kill()
