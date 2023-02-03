extends Node

# TODO: Add as parameters and adjust
const height = 10000
const min_left = 200
const max_left = 300
const steps = 100

func _ready():
	var array = PoolVector2Array()
	array.push_back(Vector2(0, 0)) # top left
	array.push_back(Vector2(0, height)) # bottom left
	
	for y in range(height, 0, -1 * steps):
		var randX = randi() % (max_left - min_left) + min_left
		array.push_back(Vector2(randX, y)) # Random offset
	
	$WallLeft/Polygon2D.polygon = array
	$WallLeft/Polygon2D.polygon = array
