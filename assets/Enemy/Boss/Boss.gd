extends "../EnemyBase.gd"

onready var boat = get_node("../Boat")

var bullet = preload("res://assets/Enemy/Boss/BossBullet.tscn")

var at_first_phase: bool = false
var at_second_phase: bool = false
var at_third_phase: bool = false

func _ready():
	max_health = 100
	
	health = max_health
	emit_signal("health_changed", health, max_health)
	

func _physics_process(delta: float) -> void:
	
	if health <= max_health * .75 && health > max_health * .50:
		first_phase_change()
		
	elif health <= max_health * .50 && health > max_health * .25:
		second_phase_change()
		
	elif health <= max_health * .25:
		third_phase_change()
		
	else:
		default_phase()
	
	
func default_phase():
	movement_speed = 50
	bullet_damage = 10
	bullet_speed = 250
	attack_rate = 1
	
	var boat_position = boat.global_position
	var direction = position.direction_to(boat_position)
	
	move_and_slide(direction * movement_speed)

	if $Attack_Rate.is_stopped():
		$Attack_Rate.wait_time = attack_rate
		$Attack_Rate.start()

func first_phase_change():
	if !at_first_phase:
		movement_speed = 0
		get_node("../Boat/Attack_Rate").stop()
		$Attack_Rate.stop()
		$Phase_Changed.play("First_phase")
		yield($Phase_Changed, "animation_finished")
		at_first_phase = true
		$Attack_Rate.start()
		get_node("../Boat/Attack_Rate").start()
		$First_Cannon.visible = true
		
	else:
		movement_speed = 100
		bullet_damage = 10
		bullet_speed = 300
		attack_rate = 1
		
		var boat_position = boat.global_position
		var direction = position.direction_to(boat_position)
	
		move_and_slide(direction * movement_speed)

func second_phase_change():
	if !at_first_phase:
		movement_speed = 0
		get_node("../Boat/Attack_Rate").stop()
		$Attack_Rate.stop()
		$Phase_Changed.play("Second_phase")
		yield($Phase_Changed, "animation_finished")
		at_second_phase = true
		$Attack_Rate.start()
		get_node("../Boat/Attack_Rate").start()

	else:
		movement_speed = 100
		bullet_damage = 10
		bullet_speed = 250
		attack_rate = 1

func third_phase_change():
	pass

func receive_damage(amount: float):
	health -= amount
	
	health = clamp(health, 0, max_health)
	emit_signal("health_changed", health, max_health)
	if health <= 0:
		death()
		
func death():
	queue_free()

func _on_Attack_Rate_timeout() -> void:
	var new_bullet = bullet.instance()
	new_bullet.add_to_group("Enemy_Bullets")
	new_bullet.position = position
	new_bullet.position.y -= 50
	new_bullet.bullet_speed = bullet_speed
	new_bullet.bullet_damage = bullet_damage
	get_parent().add_child(new_bullet)
