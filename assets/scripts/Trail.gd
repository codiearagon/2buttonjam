extends Line2D

export (int, 0, 100) var length = 40
var child_position = Vector2.ZERO
var parent_position = Vector2.ZERO
var parent_rotation = 0
var framelimiter = 0

func _process(delta):
	parent_rotation = get_parent().rotation
	parent_position = get_parent().position
	
	global_position = Vector2(0, -30).rotated(parent_rotation)
	global_rotation = 0
	
	framelimiter += delta
	
	if framelimiter > 1.0/24:
		child_position = parent_position
		add_point(parent_position)
		while get_point_count() > length:
			remove_point(0)
		
		framelimiter = 0
