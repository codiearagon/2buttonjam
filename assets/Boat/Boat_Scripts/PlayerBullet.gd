extends KinematicBody2D

var bullet_speed = 0
var bullet_damage = 0
var boat_position = Vector2.ZERO
var boat_rotation = 0
var phantom_position = Vector2.ZERO
var phantom_direction = 0
var direction = Vector2.ZERO

func _ready():
	boat_position = get_parent().get_node("./Boat").position
	boat_rotation = get_parent().get_node("./Boat").rotation
	direction.x = cos(boat_position.x - phantom_position.x)
	direction.y = sin(boat_position.y - phantom_position.y)

#	direction = Vector2(0, 1).rotated(boat_rotation)

func get_closest_enemy():
	var enemies = get_tree().get_nodes_in_group('Phantom')
	if enemies.empty(): return null

	var distances = []

	for enemy in enemies:
		var distance = get_parent().get_node("Boat").global_position.distance_squared_to(enemy.global_position)
		distances.append(distance)

	var min_distance = distances.min()
	var min_index = distances.find(min_distance)
	var closest_enemy = enemies[min_index]

	return closest_enemy
	
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
