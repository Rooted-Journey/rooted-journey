extends Line2D

const TREE_OFFSET = -18
const MOVEMENT_MULTIPLIER = 200
const ROOT_COLOR = Color(0.648438, 0.497726, 0.303955)
const CAMERA_OFFSET = 150

var tree_bottom = Vector2(0,0)
var root_position = Vector2(0,0)
var cur_direction = ''

func _enter_tree():
	var tree = get_parent().get_node("Tree")
	var mainCam = get_parent().get_node("MainCam")
	tree_bottom = tree.position + (
			Vector2(TREE_OFFSET, tree.texture.get_height() / 2)
		)
	root_position = Vector2(tree_bottom.x, mainCam.position.y)
	add_point(root_position)
	add_point(root_position)

	
func _process(delta):
	var last_point = get_point_position(points.size() -1)
	if Input.is_action_pressed("ui_left"):
		root_position -= Vector2((delta * MOVEMENT_MULTIPLIER), 0)
		if cur_direction != 'left':
			add_point(last_point)
	elif Input.is_action_pressed("ui_right"):
		root_position += Vector2((delta * MOVEMENT_MULTIPLIER), 0)
		if cur_direction != 'right':
			add_point(last_point)
	else:
		if cur_direction != '':
			add_point(last_point)

	if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		add_point(last_point)

	var mainCam = get_parent().get_node("MainCam")
	root_position.y = mainCam.position.y + CAMERA_OFFSET
	set_point_position(points.size() -1, root_position)
	print("Coordinaten", points[points.size() -1])

	# update()


#func _is_colliding():
#    var coll_point = raycast.get_collision_point()
#    laser.points[1] = to_local(coll_point)
#    particles.global_position = coll_point
#
#    var shape = RectangleShape2D.new()
#    var half_way_amount = (global_position - coll_point)/2.0
#    var center_point = global_position - half_way_amount
#    shape.extents.x = half_way_amount.rotated(rotation).x
#
#    $CollisionShape2D.shape = shape
