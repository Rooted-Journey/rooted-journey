extends Node

# TODO: Add as parameters and adjust
export var width = 1250
export var height = 10000
export var min_left = 200
export var max_left = 300
const steps = 100
const difficulty = 1.5 # multiplicator for how far the walls slide to the center

func _ready():
	var arrLeft = PoolVector2Array()
	arrLeft.push_back(Vector2(0, 0)) # top left
	arrLeft.push_back(Vector2(0, height)) # bottom left
	
	var arrRight = PoolVector2Array()
	arrRight.push_back(Vector2(width, 0)) # top right
	arrRight.push_back(Vector2(width, height)) # bottom right
	
	var min_left_eff = int(min_left * difficulty)
	var max_left_eff = int(max_left * difficulty)
	var min_right_eff = width - max_left_eff
	var max_right_eff = width - min_left_eff
	
	for y in range(height, 0, -1 * steps):
		var randXLeft = randi() % (max_left_eff - min_left_eff) + min_left_eff
		arrLeft.push_back(Vector2(randXLeft, y)) # Random offset
		
		var randXRight = randi() % (max_right_eff - min_right_eff) + min_right_eff
		arrRight.push_back(Vector2(randXRight, y)) # Random offset
	
	$WallLeft/Polygon2D.polygon = arrLeft
	$WallLeft/CollisionPolygon2D.polygon = arrLeft
	
	$WallRight/Polygon2D.polygon = arrRight
	$WallRight/CollisionPolygon2D.polygon = arrRight
