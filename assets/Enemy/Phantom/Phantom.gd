extends "../EnemyBase.gd"

var bullet = preload("./PhantomBullet.tscn")

func _ready():
	get_node("Attack_Rate").wait_time = attack_rate

func _physics_process(delta: float) -> void:
	var boat_position = get_node("../Boat").position
	var direction = position.direction_to(boat_position)
	
	if position.distance_to(boat_position) > 250:
		move_and_slide(direction * movement_speed)
		
	flip_sprite(direction)

func flip_sprite(direction):
	if sign(direction.x) < 0:
		get_node("Sprite").set_flip_h(true)
	else:
		get_node("Sprite").set_flip_h(false)

func _on_Timer_timeout() -> void:
	var new_bullet = bullet.instance()
	new_bullet.position = position
	new_bullet.position.y -= 50
	new_bullet.bullet_speed = bullet_speed
	get_parent().add_child(new_bullet)
	
