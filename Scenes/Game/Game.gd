extends Node2D

var startTime = 0
var currentTime = 0
var things = [preload("res://Assets/Graphics/mole.png"), preload("res://Assets/Graphics/lava.png"), preload("res://Assets/Graphics/uranium.png"), preload("res://Assets/Graphics/water.png")]

func _ready():
	startTime = OS.get_system_time_msecs()
	
func _process(delta):
	$MainCam.position += delta * $MainCam.camDelta
	
	if not $Meadow/VisibilityNotifier2D.is_on_screen():
		$Earth.rect_position  += delta * $MainCam.camDelta
	
	# Update Score
	currentTime = OS.get_system_time_msecs() - startTime
	$HUD/Score.text = str(currentTime)
	
	# Moles!
	if currentTime > 5000:
		if randi() % 100000000 > 99990000:
			var newMole = Sprite.new()
			newMole.position.x = randi() % int(get_viewport().size.x) + $MainCam.position.x
			newMole.position.y = randi() % int(get_viewport().size.y) + $MainCam.position.y
			newMole.centered = false;
			newMole.set_texture(things[randi() % things.size()])
			newMole.z_index = 5
			$TreeRoot.add_child(newMole);
#		
