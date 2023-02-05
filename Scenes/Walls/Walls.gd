extends Node

export var min_offset = 150
const steps = 100
const left_max_perc = 60.0;
const min_space_perc = 30.0;
const difficulty = 1 # multiplicator for how far the walls slide to the center

onready var vpSize = get_viewport().size
onready var width = ProjectSettings.get("display/window/size/width")
onready var height = int(vpSize.y)
onready var max_offset = int(width * (left_max_perc / 100)); 
onready var min_space = int(width * (min_space_perc / 100));

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
	
	var min_left_eff = int(min_offset * difficulty)
	var max_left_eff = 400 if len(oldLeft) == 0 else int(max_offset * difficulty)
	var max_right = width - min_offset
	
	for y in range(offset + height, offset, -1 * steps):
		var randXLeft = randi() % (max_left_eff - min_left_eff) + min_left_eff
		arrLeft.push_back(Vector2(randXLeft, y))

		var min_right = randXLeft + min_space;
		
		var randXRight = min_right if max_right == min_right else randi() % (max_right - min_right) + min_right
		arrRight.push_back(Vector2(randXRight, y))
		
	
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
