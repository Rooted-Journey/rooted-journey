extends Area2D

func _on_Water_body_entered(body):
	if body.name == 'Head':
		Globals.score += 100
