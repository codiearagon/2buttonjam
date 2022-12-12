extends KinematicBody2D

# Key
var obtained_key: bool = false

# Movement Variables
export (int) var maxSpeed = 50
export (float) var rotation_speed = 0.03
export (float, 1, 2) var boost_strength = 1.5
var velocity = Vector2.ZERO
var rotation_dir = 0
var speed = 0

# Movement
func get_input() -> void:
	if Input.is_action_pressed("row_left") and !Input.is_action_pressed("row_right"):
		rotation_dir += 1
		speed = maxSpeed
	if Input.is_action_pressed("row_right") and !Input.is_action_pressed("row_left"):
		rotation_dir -= 1
		speed = maxSpeed
		
	velocity = Vector2(0, -speed).rotated(rotation)
	
func _physics_process(delta: float) -> void:
	get_input()
	rotation = lerp_angle(rotation, rotation_dir * rotation_speed, delta)
	velocity = move_and_slide(velocity)
	
	speed = lerp(speed, 0, 0.05)
	speed = clamp(speed, 0, maxSpeed)
	
	# collisions
	check_gate_collision()

func check_gate_collision():
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision !=  null:
		if collision.collider.name == "Gate":
			if obtained_key:
				collision.collider.set_unlocked(true)
			else:
				print("No key")
