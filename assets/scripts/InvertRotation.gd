extends AnimatedSprite

var rotation_speed = 0.03
var rotation_dir = 0
var isFlipped = 0

func get_input() -> void:
	if Input.is_action_pressed("row_left"):
		rotation_dir -= 1
		isFlipped = 1
	if Input.is_action_pressed("row_right"):
		rotation_dir += 1
		isFlipped = 0

func _physics_process(delta: float) -> void:
	get_input()
	set_flip_h(isFlipped)
	rotation = lerp_angle(rotation, rotation_dir * rotation_speed, delta)
