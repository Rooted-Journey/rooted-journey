extends Area2D

func _on_Water_body_entered(body):
	if body.name == 'Head':
		print("Punkte um 100 erhöht!")
		Globals.score += 100
