extends Node2D

func _ready():
	$CanvasLayer/ScoreLabel.text = str(Globals.score)
	if Globals.score != 0:
		$TryAgainButton.visible = true
	else:
		$TryAgainButton.visible = false
	
