extends Node2D

export (Texture) var texture setget _set_texture

func _set_texture(value):
	texture = value
	update()
	
func _draw():
	var tree_position  = Vector2(200, 200)
	var color = Color(0.648438, 0.497726, 0.303955)
	draw_line(tree_position, Vector2(200, 400), color)
	
# Referenz aus der Doku
#func _draw():
#	var center = Vector2(200, 200)
#	var radius = 80
#	var angle_from = 75
#	var angle_to = 195
#	var color = Color(1.0, 0.0, 0.0)
#	draw_circle_arc(center, radius, angle_from, angle_to, color)
#
#func _process(delta):
#	#update()
#	pass
#
#func draw_circle_arc(center, radius, angle_from, angle_to, color):
#	var nb_points = 32
#	var points_arc = PoolVector2Array()
#
#	for i in range(nb_points + 1):
#		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
#		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
#
#	for index_point in range(nb_points):
#		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
