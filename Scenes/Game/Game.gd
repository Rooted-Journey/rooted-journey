extends Node2D

var startTime = 0
var currentTime = 0
var thingsArr = []
var thingsScenesArr = [preload("res://Scenes/Mole/MoleLeft.tscn"), preload("res://Scenes/Mole/MoleRight.tscn"), preload("res://Scenes/Water/Water.tscn"), preload("res://Scenes/Stone/Stone.tscn"), preload("res://Scenes/Uran/Uran.tscn"), preload("res://Scenes/Lava/Lava.tscn")]
var maxThingsOnScreen = 5

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

func _on_MoleTimer_timeout():
	if currentTime > 3000:
		var thingNum = randi() % thingsScenesArr.size()
		var newThing = thingsScenesArr[thingNum].instance()
		newThing.position.x = randi() % int(get_viewport().size.x)
		newThing.position.y = randi() % int(get_viewport().size.y) + $MainCam.position.y
		newThing.scale.x = 0.5
		newThing.scale.y = 0.5
		$TreeRoot.add_child(newThing)
		thingsArr.append(newThing)
		
		# Delete too many things
		if thingsArr.size() > maxThingsOnScreen:
			for i in range(thingsArr.size()-maxThingsOnScreen):
				thingsArr[i].queue_free()
				thingsArr.remove(i)
				
		# And now, make the camera faster
		$MainCam.camDelta.y += 5
		Globals.speed += 1
		$HUD/Speed.text = "Speed: " + str(Globals.speed)

func _on_TreeRoot_wall_collide():
	var _resp = get_tree().change_scene("res://Scenes/Credits/Credits.tscn")

func _on_Water_area_entered():
	pass
