extends Node

const INVINCIBILITY_DURATION = 3 #in seconds

var score = 0
var speed = 1
var invincibility_remaining = 0

func reset():
	score = 0
	speed = 0
