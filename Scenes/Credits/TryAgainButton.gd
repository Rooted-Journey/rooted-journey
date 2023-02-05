extends Button

func _on_Backbutton_pressed():
	Globals.reset()
	var _unused = get_tree().change_scene("res://Scenes/Game/Game.tscn")

func _ready():
	if Globals.score != 0:
		grab_focus()
