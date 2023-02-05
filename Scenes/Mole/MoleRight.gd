extends KinematicBody2D

func _physics_process(delta):
	var movement = Vector2(50, 0)
	move_and_slide(movement)
