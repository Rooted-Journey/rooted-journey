extends Button

func _on_Backbutton_pressed():
	var _unused = get_tree().change_scene("res://Scenes/Menu/Menu.tscn")

func _ready():
	grab_focus()
