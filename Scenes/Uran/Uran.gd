extends Area2D

func _on_Uran_body_entered(body):
	if body.name == 'Head':
		Globals.invincibility_remaining = Globals.INVINCIBILITY_DURATION
