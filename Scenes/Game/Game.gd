extends Node2D

func _ready():
	pass
	
func _process(delta):
	$MainCam.position += delta * $MainCam.camDelta
	
	if not $Meadow/VisibilityNotifier2D.is_on_screen():
		$Earth.rect_position  += delta * $MainCam.camDelta
