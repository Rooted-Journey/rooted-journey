extends Node2D

func _ready():
	$AudioStreamPlayer.play()
	$CanvasLayer/ScoreLabel.text = str(int(round(Globals.score)))
	if Globals.score != 0:
		$TryAgainButton.visible = true
	else:
		$TryAgainButton.visible = false
	
