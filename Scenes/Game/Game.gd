extends Node2D

var startTime = 0
var currentTime = 0
var things = [preload("res://Assets/Graphics/lava.png"), preload("res://Assets/Graphics/uranium.png"), preload("res://Assets/Graphics/water.png")]
var mole = preload("res://Assets/Graphics/mole.png")
var aktMole

func _ready():
	randomize()
	startTime = OS.get_system_time_msecs()
	
func _process(delta):
	$MainCam.position += delta * $MainCam.camDelta
	
	if not $Meadow/VisibilityNotifier2D.is_on_screen():
		$Earth.rect_position  += delta * $MainCam.camDelta
	
	# Update Score
	currentTime = OS.get_system_time_msecs() - startTime
	$HUD/Score.text = str(currentTime)
	
func _on_MoleTimer_timeout():
	if currentTime > 5000:
		if randi() % 10 + 1 > 5:
			var newMole = Sprite.new()
			newMole.position.x = randi() % int(get_viewport().size.x)
			newMole.position.y = randi() % int(get_viewport().size.y) + $MainCam.position.y
			newMole.centered = false;
			newMole.set_texture(mole)
			newMole.z_index = 5
			newMole.scale.x = 0.5
			newMole.scale.y = 0.5
			if randi() % 10 + 1 > 5:
				newMole.flip_h = true
			$TreeRoot.add_child(newMole)
			if aktMole:
				aktMole.queue_free()
			aktMole = newMole
		else:
			var newThing = Sprite.new()
			newThing.position.x = randi() % int(get_viewport().size.x)
			newThing.position.y = randi() % int(get_viewport().size.y) + $MainCam.position.y
			newThing.centered = false;
			newThing.set_texture(things[randi() % things.size()])
			newThing.z_index = 5
			newThing.scale.x = 0.5
			newThing.scale.y = 0.5
			$TreeRoot.add_child(newThing)
		
		# Move last mole
		if aktMole:
			if aktMole.flip_h == true:
				aktMole.position.x += 0.05
			else:
				aktMole.position.x -= 0.05
