extends AnimatedSprite

export (int) var maxSpeed = 50
export (float) var rotation_speed = 0.03
#export (float) var decay = 5

var velocity = Vector2.ZERO
var rotation_dir = 0
var speed = 0

func get_input() -> void:
	if Input.is_action_pressed("row_left"):
		rotation_dir -= 1
		speed = maxSpeed
	if Input.is_action_pressed("row_right"):
		rotation_dir += 1
		speed = maxSpeed
		
	velocity = Vector2(0, -speed).rotated(rotation)
	

func _physics_process(delta: float) -> void:
	get_input()
	rotation = lerp_angle(rotation, rotation_dir * rotation_speed, delta)
	
	speed = lerp(speed, 0, 0.05)
	speed = clamp(speed, 0, maxSpeed)
