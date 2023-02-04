extends Node2D

const TREE_OFFSET = 18

func _draw():
	var tree = get_parent().get_node("Tree")
	var tree_bottom = tree.position - (Vector2(TREE_OFFSET, tree.texture.get_height() / 2))
	var mainCam = get_parent().get_node("MainCam")
	var color = Color(0.648438, 0.497726, 0.303955)
	draw_line(tree_bottom, Vector2(tree_bottom.x, mainCam.position.y), color, 5.0)
	
func _process(_delta):
	if Input.is_action_pressed("ui_left"):
		
		pass
	if Input.is_action_pressed("ui_right"):
		pass
	update()
