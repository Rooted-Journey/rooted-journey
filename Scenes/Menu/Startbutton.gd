extends Button

func _on_Startbutton_pressed():
	Globals.reset()
	var _unused = get_tree().change_scene("res://Scenes/Game/Game.tscn")

func _ready():
	grab_focus()
