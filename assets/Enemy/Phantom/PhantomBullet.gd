extends KinematicBody2D

var bullet_speed = 0
var boat_position

func _ready():
	pass

func _physics_process(delta: float) -> void:
	boat_position = get_node("../Boat").position
	var direction = position.direction_to(boat_position)
	move_and_slide(direction * bullet_speed)
	
	# Delete on hit
	check_boat_collision()

	
func check_boat_collision():
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision !=  null:
		if collision.collider.name == "Boat":
			queue_free()
