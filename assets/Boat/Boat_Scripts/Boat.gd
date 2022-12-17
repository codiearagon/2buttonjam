extends KinematicBody2D

# Distance
export(float, 100, 300) var max_distance = 100.0
var current_phantoms
var phantom_quantity

# Health
signal health_changed(value, max_value)

export var max_health: int = 100
var health: int = 0

# Attack
export var bullet_damage: int
export var bullet_speed: float
export var attack_rate: float

var bullet = preload("../PlayerBullet.tscn")

# Key
signal obtained_key(value)

var have_key: bool = false

# Movement Variables
export var max_speed: int = 50
export var rotation_speed: float = 0.03
var velocity = Vector2.ZERO
var rotation_dir = 0
var speed = 0

func check_near_enemy() -> bool: 
	phantom_quantity = get_tree().get_nodes_in_group("Enemies").size()
	current_phantoms = get_tree().get_nodes_in_group("Enemies")
	var closest_distance:Vector2
	var float_distance:float
	
	for enemy in phantom_quantity:
		if current_phantoms[enemy].position.distance_to($Center.position) < closest_distance.distance_to($Center.position):
			float_distance = current_phantoms[enemy].position.distance_to($Center.position)
	
	return abs(float_distance) < max_distance

func check_distance():
	var is_near:bool
	return is_near

func _ready():
	health = max_health
	
	get_node("Attack_Rate").wait_time = attack_rate
	emit_signal("health_changed", health, max_health)
	emit_signal("obtained_key", have_key)

func _physics_process(delta: float) -> void:
	get_input()
	rotation = lerp_angle(rotation, rotation_dir * rotation_speed, delta)
	velocity = move_and_slide(velocity)
	
	speed = lerp(speed, 0, 0.05)
	speed = clamp(speed, 0, max_speed)
	
	# collisions
	check_gate_collision()
	
func get_input() -> void:
	if Input.is_action_pressed("row_left") and !Input.is_action_pressed("row_right"):
		rotation_dir += 1
		speed = max_speed
	if Input.is_action_pressed("row_right") and !Input.is_action_pressed("row_left"):
		rotation_dir -= 1
		speed = max_speed
			
	velocity = Vector2(0, -speed).rotated(rotation)
	
	
func check_gate_collision():
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision !=  null:
		if collision.collider.name == "Gate":
			if have_key:
				collision.collider.set_unlocked(true)

func obtained_key():
	have_key = true
	emit_signal("obtained_key", have_key)

func take_damage(amount: int):
	health -= amount
	health = clamp(health, 0, 100)
	emit_signal("health_changed", health, max_health)
	
	if health <= 0:
		SceneTransition.change_scene("res://assets/Scenes/Death.tscn")

func _on_Attack_Rate_timeout() -> void:
	current_phantoms = get_tree().get_nodes_in_group("Enemies")
	if current_phantoms.size() != 0 and check_near_enemy():
		var new_bullet = bullet.instance()
		new_bullet.position = get_node("Center").global_position
		new_bullet.bullet_speed = bullet_speed
		new_bullet.bullet_damage = bullet_damage
		get_parent().add_child(new_bullet)
		pass
