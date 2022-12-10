extends Line2D

export (int, 0, 100) var length = 20
var child_position = Vector2.ZERO
var framelimiter = 0

func _process(delta):
	
	global_position = Vector2.ZERO
	global_rotation = 0
	
	framelimiter += delta
	
	if framelimiter > 1.0/24:
		child_position.x = get_parent().global_position.x
		child_position.y = get_parent().global_position.y
		add_point(child_position)
		
		while get_point_count() > length:
			remove_point(0)
		
		framelimiter = 0
