extends Line2D

const touch_offset = 30

onready var cam = get_parent().get_node("MainCam")
onready var tree = get_parent().get_node("Tree")
onready var treebottom = tree.position.y + tree.texture.get_height() * tree.scale.y / 2 - 50
onready var xCoord = tree.position.x;
onready var normal_root = load("res://Assets/Graphics/root.png")
onready var uranium_root = load("res://Assets/Graphics/root_uranium.png")

var yoffset = 0

signal wall_collide

func _ready():
	add_point(Vector2(xCoord, treebottom))
	$Head.position = Vector2(xCoord, treebottom)

func _physics_process(delta):
	if cam.position.y < treebottom:
		return
		
	var xDelta = delta * (300 + Globals.speed)
	var yDelta = delta * 100

	if Input.is_action_pressed("ui_right"):
		xCoord += xDelta
	if Input.is_action_pressed("ui_left"):
		xCoord -= xDelta
	if Input.is_action_pressed("ui_up"):
		yoffset -= yDelta
	if Input.is_action_pressed("ui_down"):
		yoffset += yDelta
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		var localMousePos = get_local_mouse_position()
		var xDiff = localMousePos.x - $Head.position.x
		var yDiff = localMousePos.y - $Head.position.y

		if xDiff > touch_offset:
			xCoord += xDelta
		elif xDiff < -touch_offset:
			xCoord -= xDelta

		if yDiff > touch_offset:
			yoffset += yDelta
		elif yDiff < -touch_offset:
			yoffset -= yDelta
	
	var lastPoint = points[points.size() - 1]
	var newPoint = Vector2(xCoord, cam.position.y + yoffset)

	var diff = newPoint - lastPoint
	$Head.rotation = Vector2.DOWN.angle_to(diff)

	var coll = $Head.move_and_collide(diff)
	if coll:
		if not handle_collision(coll):
			return

	add_point(newPoint)
	
	while get_point_count() > 200:
		remove_point(0)
		
	#Handle invisibility
	if Globals.invincibility_remaining > 0:
		$Head/RootHead.texture = uranium_root
	else:
		$Head/RootHead.texture = normal_root

	update()

func handle_collision(coll: KinematicCollision2D):	
	if coll.collider.is_in_group("OBSTACLE"):
		if coll.collider.is_in_group("WALL"):
			emit_signal("wall_collide")
			return false;
		if Globals.invincibility_remaining <= 0:
			emit_signal("wall_collide")
			return false
	
	return true
