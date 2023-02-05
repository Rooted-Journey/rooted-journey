extends Button

func _on_Backbutton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")

func _ready():
	grab_focus()
