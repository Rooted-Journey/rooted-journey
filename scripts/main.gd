extends Node2D

onready var cam = $mainCam

func _ready():
	pass
	
func _process(delta):
	var pos = cam.position
	pos.y = pos.y + 0.01
	cam.set_position(pos)
	
