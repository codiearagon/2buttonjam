extends AnimatedSprite

export (int) var maxSpeed = 50
export (float) var rotation_speed = 0.03
export var sprite_scale = Vector2(1.75, 1.75)
#export (float) var decay = 5

var velocity = Vector2.ZERO
var rotation_dir = 0
var speed = 0
var isFlipped = 0

func get_input() -> void:
	if Input.is_action_pressed("row_left"):
		rotation_dir -= 1
		speed = maxSpeed
		isFlipped = 1
	if Input.is_action_pressed("row_right"):
		rotation_dir += 1
		speed = maxSpeed
		isFlipped = 0
	velocity = Vector2(0, -speed).rotated(rotation)

func _physics_process(delta: float) -> void:
	get_input()
	#flips the sprite (happens when an input happens)
	set_flip_h(isFlipped)

	rotation = lerp_angle(rotation, rotation_dir * rotation_speed, delta)
	
	speed = lerp(speed, 0, 0.05)
	speed = clamp(speed, 0, maxSpeed)
