extends "../EnemyBase.gd"

onready var boat = get_node("../Boat")

var boss_bullet = preload("res://assets/Enemy/Boss/BossBullet.tscn")
var cannon_bullet = preload("res://assets/Enemy/Boss/CannonBullet.tscn")

var at_first_phase: bool = false
var at_second_phase: bool = false
var at_third_phase: bool = false

var phase = 0

func _ready():
	max_health = 100
	
	health = max_health
	emit_signal("health_changed", health, max_health)
	

func _physics_process(delta: float) -> void:
	
	if health > 0:
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
		$Phase_Changed.play("Change")
		clear_all_bullets()
		$First_Cannon/RevealTween.interpolate_method($First_Cannon, "set_modulate", $First_Cannon.modulate, Color8(255, 255, 255), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$First_Cannon/RevealTween.start()
		yield($Phase_Changed, "animation_finished")
		at_first_phase = true
		phase = 1
		$Attack_Rate.start()
		get_node("../Boat/Attack_Rate").start()
		
	else:
		movement_speed = 45
		bullet_damage = 10
		bullet_speed = 300
		attack_rate = 1.5
		
		var boat_position = boat.global_position
		var direction = position.direction_to(boat_position)
	
		move_and_slide(direction * movement_speed)

func second_phase_change():
	if !at_second_phase:
		movement_speed = 0
		get_node("../Boat/Attack_Rate").stop()
		$Attack_Rate.stop()
		$Phase_Changed.play("Change")
		clear_all_bullets()
		$Second_Cannon/RevealTween.interpolate_method($Second_Cannon, "set_modulate", $Second_Cannon.modulate, Color8(255, 255, 255), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Second_Cannon/RevealTween.start()
		yield($Phase_Changed, "animation_finished")
		at_second_phase = true
		phase = 2
		$Attack_Rate.start()
		get_node("../Boat/Attack_Rate").start()

	else:
		movement_speed = 45
		bullet_damage = 10
		bullet_speed = 350
		attack_rate = 3
		
		var boat_position = boat.global_position
		var direction = position.direction_to(boat_position)
	
		move_and_slide(direction * movement_speed)

func third_phase_change():
	if !at_third_phase:
		movement_speed = 0
		get_node("../Boat/Attack_Rate").stop()
		$Attack_Rate.stop()
		$Phase_Changed.play("Change")
		clear_all_bullets()
		$Third_Cannon/RevealTween.interpolate_method($Third_Cannon, "set_modulate", $Third_Cannon.modulate, Color8(255, 255, 255), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Third_Cannon/RevealTween.start()
		yield($Phase_Changed, "animation_finished")
		at_third_phase = true
		phase = 3
		$Attack_Rate.start()
		get_node("../Boat/Attack_Rate").start()

	else:
		movement_speed = 30
		bullet_damage = 10
		bullet_speed = 200
		attack_rate = 1
		
		var boat_position = boat.global_position
		var direction = position.direction_to(boat_position)
	
		move_and_slide(direction * movement_speed)

func receive_damage(amount: float):
	health -= amount
	
	health = clamp(health, 0, max_health)
	$On_HitSFX.play()
	emit_signal("health_changed", health, max_health)
	if health <= 0:
		death()
		
func death():
	movement_speed = 0
	get_node("../Boat/Attack_Rate").stop()
	$Attack_Rate.stop()
	$Phase_Changed.play("Change")
	clear_all_bullets()
	$DeathTween.interpolate_method(self, "set_modulate", self.modulate, Color8(255, 255,  255, 0), 2.0, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$First_Cannon/RevealTween.interpolate_method($First_Cannon, "set_modulate", $First_Cannon.modulate, Color8(255, 255,  255, 0), 1.0, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Second_Cannon/RevealTween.interpolate_method($Second_Cannon, "set_modulate", $Second_Cannon.modulate, Color8(255, 255,  255, 0), 1.0, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Third_Cannon/RevealTween.interpolate_method($Third_Cannon, "set_modulate", $Third_Cannon.modulate, Color8(255, 255,  255, 0), 1.0, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$DeathTween.start()
	$First_Cannon/RevealTween.start()
	$Second_Cannon/RevealTween.start()
	$Third_Cannon/RevealTween.start()
	yield($Phase_Changed, "animation_finished")
	queue_free()
	
	SceneTransition.change_scene("res://assets/Scenes/Win.tscn")

func _on_Attack_Rate_timeout() -> void:
	if phase == 1:
		spawn_boss_bullet()
		spawn_cannon_bullet($First_Cannon/Muzzle)
	elif phase == 2:
		spawn_boss_bullet()
		spawn_cannon_bullet($First_Cannon/Muzzle)
		spawn_cannon_bullet($Second_Cannon/Muzzle)
		
	elif phase == 3:
		spawn_boss_bullet()
		spawn_cannon_bullet($First_Cannon/Muzzle)
		spawn_cannon_bullet($Second_Cannon/Muzzle)
		spawn_cannon_bullet($Third_Cannon/Muzzle)
	
	else:
		spawn_boss_bullet()
	
func spawn_boss_bullet():
	var new_bullet = boss_bullet.instance()
	new_bullet.add_to_group("Enemy_Bullets")
	new_bullet.position = position
	new_bullet.position.y -= 50
	new_bullet.bullet_speed = bullet_speed
	new_bullet.bullet_damage = bullet_damage
	get_parent().add_child(new_bullet)
	
func spawn_cannon_bullet(cannon):
	var new_bullet = cannon_bullet.instance()
	new_bullet.add_to_group("Enemy_Bullets")
	new_bullet.position = cannon.global_position
	new_bullet.bullet_speed = bullet_speed
	new_bullet.bullet_damage = bullet_damage
	get_parent().add_child(new_bullet)

func clear_all_bullets():
	var enemy_bullets = get_tree().get_nodes_in_group("Enemy_Bullets")
	
	for bullet in enemy_bullets:
		bullet.queue_free()
