extends Line2D

onready var cam = get_parent().get_node("MainCam")
onready var tree = get_parent().get_node("Tree")
onready var treebottom = tree.position.y + tree.texture.get_height() * tree.scale.y / 2

func _ready():
	add_point(Vector2(cam.position.x, treebottom))

func _process(_delta):
	if cam.position.y > treebottom:
		add_point(cam.position)
		update()
