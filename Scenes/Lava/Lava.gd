extends StaticBody2D

func _process(_delta):
	if Globals.invincibility_remaining <= 0:
		collision_mask = 1
		collision_layer = 1
	else:
		collision_mask = 2
		collision_layer = 2
