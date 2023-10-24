extends Node2D

var grid_size = DisplayServer.screen_get_size()
var cell_size = Vector2(16,16)
var cells_amount = Vector2(grid_size.x/cell_size.x, grid_size.y/cell_size.y)

var draw_grid = false

func _on_button_pressed():
	draw_grid = true
	queue_redraw()
	
func _on_button_2_pressed():
	draw_grid = true
	queue_redraw()
	
func _on_button_3_pressed():
	draw_grid = false
	queue_redraw()

func _draw():
	if draw_grid:
		# Draws horitonzal grid lines
		for i in cells_amount.x:
			var from = Vector2(i*cell_size.x, 0)
			var to = Vector2(from.x, grid_size.y)
			draw_line(from, to, Color.BLACK)
		
		# Draws vertical grid lines
		for i in cells_amount.x:
			var from = Vector2(0, cell_size.y*i)
			var to = Vector2(grid_size.x, from.y)
			draw_line(from, to, Color.BLACK)
