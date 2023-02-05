extends Node2D

func _ready():
	$CanvasLayer/ScoreLabel.text = str(Globals.score)
