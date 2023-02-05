extends Node

const INVINCIBILITY_DURATION = 5
const WATER_POINTS = 10
const STONE_POINTS = -10

var score = 0
var speed = 1
var invincibility_remaining = 0

func reset():
	score = 0
	speed = 0
	invincibility_remaining = 0
