extends Node2D

var startTime = 0
var currentTime = 0
var thingsArr = []
var molesArr = []
var moleScenesArr = [preload("res://Scenes/Mole/MoleLeft.tscn"), preload("res://Scenes/Mole/MoleRight.tscn")]
var thingsScenesArr = [preload("res://Scenes/Water/Water.tscn"), preload("res://Scenes/Stone/Stone.tscn"), preload("res://Scenes/Uran/Uran.tscn"), preload("res://Scenes/Lava/Lava.tscn")]
var maxThingsOnScreen = 30

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
	Globals.score += delta
	$HUD/Score.text = str(int(round(Globals.score)))

	# Check invincibility
	if Globals.invincibility_remaining > 0:
		Globals.invincibility_remaining -= delta

func _on_MoleTimer_timeout():
	if currentTime > 3000:
		if randi() % 2 == 1:
			# Thing
			var thingNum = randi() % thingsScenesArr.size()
			var newThing = thingsScenesArr[thingNum].instance()
			newThing.position.x = randi() % int(get_viewport().size.x)
			newThing.position.y = randi() % int(get_viewport().size.y) + $MainCam.position.y
			newThing.scale.x = 0.5
			newThing.scale.y = 0.5
			$TreeRoot.add_child(newThing)
			thingsArr.append(newThing)
		else:
			# Mole
			var moleNum = randi() % moleScenesArr.size()
			var newMole = moleScenesArr[moleNum].instance()
			if newMole.name == "MoleLeft":
				newMole.position.x = get_viewport().size.x
			else:
				newMole.position.x = 0
			newMole.position.y = randi() % int(get_viewport().size.y) + $MainCam.position.y
			newMole.scale.x = 0.5
			newMole.scale.y = 0.5
			$TreeRoot.add_child(newMole)
			molesArr.append(newMole)
		
		# Delete too many things
		if thingsArr.size() > maxThingsOnScreen / 2:
			for i in range(thingsArr.size()-maxThingsOnScreen):
				thingsArr[i].queue_free()
				thingsArr.remove(i)
		if molesArr.size() > maxThingsOnScreen / 2:
			for i in range(molesArr.size()-maxThingsOnScreen):
				molesArr[i].queue_free()
				molesArr.remove(i)
				
		# And now, make the camera faster
		$MainCam.camDelta.y += 5
		Globals.speed += 1
		$HUD/Speed.text = "Speed: " + str(Globals.speed)

func _on_TreeRoot_wall_collide():
	var _resp = get_tree().change_scene("res://Scenes/Credits/Credits.tscn")

func _on_Water_area_entered():
	pass
