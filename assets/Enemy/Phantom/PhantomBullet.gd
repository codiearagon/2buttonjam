extends KinematicBody2D

var bullet_speed = 0
var bullet_damage = 0
var boat_position = Vector2.ZERO
var direction = Vector2.ZERO

func _ready():
	boat_position = get_node("../Boat/Center").global_position
	direction = position.direction_to(boat_position)
	pass

func _physics_process(delta: float) -> void:	
	move_and_slide(direction * bullet_speed)
	
	# Delete on hit
	check_boat_collision()

	
func check_boat_collision():
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision !=  null:
		#print(collision.collider.name)
		if collision.collider.name == "Boat":
			var boat = collision.collider
			boat.take_damage(bullet_damage)
			queue_free()
		elif collision.collider.name == "Deflector":
			bounce(collision)
			set_collision_layer_bit(3, false)
			set_collision_layer_bit(5, true)
		elif collision.collider.name == "Walls":
			queue_free()
			
		elif collision.collider.name == "Phantom" && get_collision_layer_bit(5):
			var phantom = collision.collider
			phantom.receive_damage(bullet_damage)
			queue_free()

func bounce(collision):
	direction = direction.bounce(collision.normal)
			
