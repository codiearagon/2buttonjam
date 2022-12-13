extends "../EnemyBase.gd"

var bullet = preload("./PhantomBullet.tscn")

func _ready():
	get_node("Attack_Rate").wait_time = attack_rate
	emit_signal("health_changed", health)

func _physics_process(delta: float) -> void:
	var boat_position = get_node("../Boat").global_position
	var direction = position.direction_to(boat_position)
	
	#print(boat_position.normalized().dot(global_position.normalized()))
	
	if position.distance_to(boat_position) >= 250:
		move_and_slide(direction * movement_speed)
		
	flip_sprite(direction)

func flip_sprite(direction):
	if sign(direction.x) < 0:
		get_node("Sprite").set_flip_h(true)
	else:
		get_node("Sprite").set_flip_h(false)

func _on_Attack_Rate_timeout() -> void:
	var new_bullet = bullet.instance()
	new_bullet.position = position
	new_bullet.position.y -= 50
	new_bullet.bullet_speed = bullet_speed
	new_bullet.bullet_damage = bullet_damage
	get_parent().add_child(new_bullet)

func receive_damage(amount: float):
	health -= amount
	health = clamp(health, 0, 10)
	
	emit_signal("health_changed", health)
	if health <= 0:
		queue_free()
