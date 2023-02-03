extends Node2D

onready var cam = $MainCam
onready var earth = $Earth
onready var meadow = $Meadow
const camDelta = Vector2(0, 100)

func _ready():
	pass
	
func _process(delta):
	cam.position += delta * camDelta
	
	if not $Meadow/VisibilityNotifier2D.is_on_screen():
		earth.position += delta * camDelta
