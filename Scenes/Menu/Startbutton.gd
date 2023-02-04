extends Button

func _on_Startbutton_pressed():
	assert(get_tree().change_scene("res://Scenes/Game/Game.tscn") == OK)
