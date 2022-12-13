extends KinematicBody2D

# Health
signal health_changed(value)

export var max_health: int = 100
var health: int = 0

# Key
signal obtained_key(value)

var obtained_key: bool = false

# Movement Variables
export var maxSpeed: int = 50
export var rotation_speed: float = 0.03
var velocity = Vector2.ZERO
var rotation_dir = 0
var speed = 0

func _ready():
	health = max_health
	emit_signal("health_changed", health)
	emit_signal("obtained_key", obtained_key)

func _physics_process(delta: float) -> void:
	get_input()
	rotation = lerp_angle(rotation, rotation_dir * rotation_speed, delta)
	velocity = move_and_slide(velocity)
	
	speed = lerp(speed, 0, 0.05)
	speed = clamp(speed, 0, maxSpeed)
	
	# collisions
	check_gate_collision()
	
	
func get_input() -> void:
	if Input.is_action_pressed("row_left"):
		rotation_dir += 1
		speed = maxSpeed
	if Input.is_action_pressed("row_right"):
		rotation_dir -= 1
		speed = maxSpeed
		
	velocity = Vector2(0, -speed).rotated(rotation)
	
	
func check_gate_collision():
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision !=  null:
		if collision.collider.name == "Gate":
			if obtained_key:
				collision.collider.set_unlocked(true)

func obtained_key():
	obtained_key = true
	emit_signal("obtained_key", obtained_key)

func take_damage(amount: int):
	health -= amount
	health = clamp(health, 0, 100)
	emit_signal("health_changed", health)
