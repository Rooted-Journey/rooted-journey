extends Node2D
const camDelta = Vector2(0, 100)

func _ready():
	pass
	
func _process(delta):
	$MainCam.position += delta * camDelta
	
	if not $Meadow/VisibilityNotifier2D.is_on_screen():
		$Earth.rect_position  += delta * camDelta
