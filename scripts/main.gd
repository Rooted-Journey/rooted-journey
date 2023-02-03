extends Node2D

onready var cam = $mainCam
var camDelta = Vector2(0, 100)

func _ready():
	pass
	
func _process(delta):
	cam.position += delta * camDelta
