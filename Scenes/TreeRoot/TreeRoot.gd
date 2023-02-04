extends Line2D

onready var cam = get_parent().get_node("MainCam")
onready var tree = get_parent().get_node("Tree")
onready var treebottom = tree.position.y + tree.texture.get_height() * tree.scale.y / 2
onready var xCoord = tree.position.x;
export var speedMultiplier = 200

func _ready():
	add_point(Vector2(xCoord, treebottom))

func _process(delta):
	if cam.position.y < treebottom:
		return

	if(Input.is_action_pressed("ui_right")):
		xCoord += delta * speedMultiplier
	if(Input.is_action_pressed("ui_left")):
		xCoord -= delta * speedMultiplier
	
	add_point(Vector2(xCoord, cam.position.y))
	
	while get_point_count() > 1000:
		remove_point(0)
	
	update()
