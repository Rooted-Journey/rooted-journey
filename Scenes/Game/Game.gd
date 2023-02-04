extends Node2D

var startTime = 0
var currentTime = 0

func _ready():
	startTime = OS.get_system_time_msecs()
	
func _process(delta):
	$MainCam.position += delta * $MainCam.camDelta
	
	if not $Meadow/VisibilityNotifier2D.is_on_screen():
		$Earth.rect_position  += delta * $MainCam.camDelta
		
	currentTime = OS.get_system_time_msecs() - startTime
	$HUD/Score.text = str(currentTime)
