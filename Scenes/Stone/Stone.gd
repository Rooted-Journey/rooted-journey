extends Area2D

func _on_Stone_body_entered(body):
	if body.name == 'Head':
		Globals.score -= 100
