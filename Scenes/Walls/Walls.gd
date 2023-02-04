extends Node

# TODO: Add as parameters and adjust
export var min_left = 200
export var max_left = 300
const steps = 100
const difficulty = 1 # multiplicator for how far the walls slide to the center

onready var vpSize = get_viewport().size
onready var width = int(vpSize.x)
onready var height = int(vpSize.y)

var offset = 0

func _ready():	
	regenerate_walls()

func _process(_delta):
	if $VisibilityNotifier2D.is_on_screen():
		regenerate_walls()

func regenerate_walls():
	var oldLeft = $WallLeft/Polygon2D.polygon
	var oldRight = $WallRight/Polygon2D.polygon
	
	var arrLeft = PoolVector2Array()
	arrLeft.push_back(Vector2(0, offset)) # top left
	arrLeft.push_back(Vector2(0, height + offset)) # bottom left
	
	var arrRight = PoolVector2Array()
	arrRight.push_back(Vector2(width, offset)) # top right
	arrRight.push_back(Vector2(width, height + offset)) # bottom right
	
	var min_left_eff = int(min_left * difficulty)
	var max_left_eff = int(max_left * difficulty)
	var min_right_eff = width - max_left_eff
	var max_right_eff = width - min_left_eff
	
	for y in range(offset + height, offset, -1 * steps):
		var randXLeft = randi() % (max_left_eff - min_left_eff) + min_left_eff
		arrLeft.push_back(Vector2(randXLeft, y)) # Random offset
		
		var randXRight = randi() % (max_right_eff - min_right_eff) + min_right_eff
		arrRight.push_back(Vector2(randXRight, y)) # Random offset
		
	
	var leftMerged = _merge_polygons(oldLeft, arrLeft)
	$WallLeft/Polygon2D.polygon = leftMerged
	$WallLeft/CollisionPolygon2D.polygon = leftMerged
	
	var rightMerged = _merge_polygons(oldRight, arrRight)
	$WallRight/Polygon2D.polygon = rightMerged
	$WallRight/CollisionPolygon2D.polygon = rightMerged
	
	offset += height
	$VisibilityNotifier2D.position += Vector2(0, height)
	
func _merge_polygons(old: PoolVector2Array, new: PoolVector2Array):	
	if len(old) == 0:
		return new
	
	var newArr = PoolVector2Array()
	newArr.push_back(old[0])
	
	for i in range (1, len(new)):
		newArr.push_back(new[i])
	
	for i in range (2, len(old)):
		newArr.push_back(old[i])
		
	return newArr
