extends Node2D

const TREE_POSITION = Vector2(200, 200)
	
func _draw():
	var mainCam = get_parent().get_node("MainCam")
	var color = Color(0.648438, 0.497726, 0.303955)
	draw_line(TREE_POSITION, Vector2(200, mainCam.position.y), color)
	
func _process(_delta):
	update()
