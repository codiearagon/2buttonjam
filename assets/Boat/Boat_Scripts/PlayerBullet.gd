extends KinematicBody2D


var bullet_speed = 0
var bullet_damage = 0
var boat_position = Vector2.ZERO
var boat_rotation = 0
var phantom_quantity
var current_phantoms
var priority_position:Vector2
var direction = Vector2.ZERO

func _ready():
	load("res://assets/Enemy/Spawner.tscn")
	phantom_quantity = get_tree().get_nodes_in_group("Enemies").size()
	boat_position = get_parent().get_node("./Boat").position
	boat_rotation = get_parent().get_node("./Boat").rotation
	if phantom_quantity > 0:
		priority_position = get_closest_enemy()
		direction = position.direction_to(priority_position)

func get_closest_enemy() -> Vector2:
	
	phantom_quantity = get_tree().get_nodes_in_group("Enemies").size()
	current_phantoms = get_tree().get_nodes_in_group("Enemies")
	var closest_position:Vector2
	
	for enemy in phantom_quantity:
		
		if current_phantoms[enemy].position.distance_to(boat_position) < closest_position.distance_to(boat_position):
			closest_position = current_phantoms[enemy].position
			closest_position.y -= 64
	return closest_position
	
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
