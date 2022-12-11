extends AnimatedSprite

var sprite_position = Vector2.ZERO
var framelimiter = 0
var isUp = -1

func _process(delta):

	
	framelimiter += delta
	
	if framelimiter > 1.0/1:
		isUp *= -1
		sprite_position.y = -1.5 * isUp
		sprite_position.x = 1.5 * isUp
		set_offset(sprite_position)
		framelimiter = 0
