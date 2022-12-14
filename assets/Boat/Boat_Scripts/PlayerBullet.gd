extends KinematicBody2D

var bullet_speed = 0
var bullet_damage = 0
var boat_position = Vector2.ZERO
var boat_rotation = 0
var direction = Vector2.ZERO

func _ready():
	boat_position = get_parent().get_node("./Boat").position
	boat_rotation = get_parent().get_node("./Boat").rotation
	direction = Vector2(0, -1).rotated(boat_rotation)
	
func _physics_process(delta: float) -> void: 
	move_and_slide(direction * bullet_speed)
	
	check_enemy_collision()

func check_enemy_collision():
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision !=  null:
		#print(collision.collider.get_collision_layer())
		if collision.collider.get_collision_layer_bit(2):
			var phantom = collision.collider
			phantom.receive_damage(bullet_damage)
			queue_free()
		if collision.collider.get_collision_layer_bit(3):
			collision.collider.queue_free()
			queue_free()
		elif collision.collider.name == "Walls":
			queue_free()
