extends Node2D

var startTime = 0
var currentTime = 0
var things = [preload("res://Assets/Graphics/lava.png"), preload("res://Assets/Graphics/uranium.png"), preload("res://Assets/Graphics/water.png")]
var mole = preload("res://Assets/Graphics/mole.png")
var moleArr = []

func _ready():
	randomize()
	startTime = OS.get_system_time_msecs()
	$HUD/Speed.text = "Speed: " + str($MainCam.camDelta.y - 100)
	
func _process(delta):
	$MainCam.position += delta * $MainCam.camDelta
	
	if not $Meadow/VisibilityNotifier2D.is_on_screen():
		$Earth.rect_position  += delta * $MainCam.camDelta
	
	# Update Score
	currentTime = OS.get_system_time_msecs() - startTime
	$HUD/Score.text = str(currentTime/100)
	
	# Move the moles
	if moleArr.size() > 0:
		for i in range(moleArr.size()):
			if moleArr[i].flip_h == true:
				moleArr[i].position.x += delta * 100
			else:
				moleArr[i].position.x -= delta * 100
	
func _on_MoleTimer_timeout():
	if randi() % 10 + 1 >= 5:
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
		$Walls.add_child(newMole)
		moleArr.append(newMole)
	else:
		var newThing = Sprite.new()
		newThing.position.x = randi() % int(get_viewport().size.x)
		newThing.position.y = randi() % int(get_viewport().size.y) + $MainCam.position.y
		newThing.centered = false;
		newThing.set_texture(things[randi() % things.size()])
		newThing.z_index = 5
		newThing.scale.x = 0.5
		newThing.scale.y = 0.5
		$Walls.add_child(newThing)
	
	# Delete too many moles - 10 should be enough at all times
	if moleArr.size() > 10:
		for i in range(moleArr.size()-10):
			moleArr[i].queue_free()
			moleArr.remove(i)
			
	# And now, make the camera faster
	$MainCam.camDelta.y += 5
	$HUD/Speed.text = "Speed: " + str($MainCam.camDelta.y - 100)


func _on_TreeRoot_wall_collide():
	var _resp = get_tree().change_scene("res://Scenes/Credits/Credits.tscn")
