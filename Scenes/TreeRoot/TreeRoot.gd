extends Node2D

const TREE_OFFSET = -18
const MOVEMENT_MULTIPLIER = 0.2
const ROOT_COLOR = Color(0.648438, 0.497726, 0.303955)
const MEADOW_OFFSET = 64

var tree_bottom = Vector2(0,0)
var root_position = Vector2(0,0)

func _enter_tree():
	var tree = get_parent().get_node("Tree")
	var mainCam = get_parent().get_node("MainCam")
	tree_bottom = tree.position + (Vector2(TREE_OFFSET, (tree.texture.get_height() / 2) + MEADOW_OFFSET))
	root_position = Vector2(tree_bottom.x, mainCam.position.y)

func _draw():
	var mainCam = get_parent().get_node("MainCam")

	root_position.y = mainCam.position.y
	draw_line(tree_bottom, root_position, ROOT_COLOR, 5.0)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		root_position += Vector2(root_position.x - (delta * MOVEMENT_MULTIPLIER), 0)

	if Input.is_action_pressed("ui_right"):
		pass
	update()
