extends Sprite

export (float, 0, 1) var rotation_speed = 0.3
var rotation_dir = 0
var side = 0

func get_input() -> void:
	if Input.is_action_pressed("row_left"):
		side = 0
	if Input.is_action_pressed("row_right"):
		side = 1

func _physics_process(delta: float) -> void:
	get_input()
	rotation = lerp_angle(rotation, side * PI , rotation_speed)
