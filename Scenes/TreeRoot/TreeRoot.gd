extends Line2D

onready var cam = get_parent().get_node("MainCam")
onready var tree = get_parent().get_node("Tree")
onready var treebottom = tree.position.y + tree.texture.get_height() * tree.scale.y / 2 - 50
onready var xCoord = tree.position.x;
onready var normal_root = load("res://Assets/Graphics/root.png")
onready var uranium_root = load("res://Assets/Graphics/root_uranium.png")

signal wall_collide

func _ready():
	add_point(Vector2(xCoord, treebottom))
	$Head.position = Vector2(xCoord, treebottom)

func _physics_process(delta):
	if cam.position.y < treebottom:
		return
		
	var xDelta = delta * (300 + Globals.speed)

	if Input.is_action_pressed("ui_right"):
		xCoord += xDelta
	if Input.is_action_pressed("ui_left"):
		xCoord -= xDelta
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		if get_local_mouse_position().x > $Head.position.x:
			xCoord += xDelta
		else:
			xCoord -= xDelta
	
	var lastPoint = points[points.size() - 1]
	var newPoint = Vector2(xCoord, cam.position.y)
	var diff = newPoint - lastPoint
	$Head/RootHead.rotation = diff.angle() - Vector2.DOWN.angle()

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
