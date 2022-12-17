extends KinematicBody2D

var bullet_speed = 0
var bullet_damage = 0
var boat_position = Vector2.ZERO
var direction = Vector2.ZERO

func _ready():
	boat_position = get_node("../Boat/Center").global_position
	direction = position.direction_to(boat_position)

func _physics_process(delta: float) -> void:
	move_and_slide(direction * bullet_speed)
	
	# Delete on hit
	check_boat_collision()

	
func check_boat_collision():
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision !=  null:
		#print(collision.collider_shape)
		if collision.collider.name == "Boat":
			var boat = collision.collider
			boat.take_damage(bullet_damage)
			queue_free()



func _on_VisibilityNotifier2D_viewport_exited(viewport: Viewport) -> void:
	queue_free()
