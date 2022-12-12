extends Sprite

export (float, 0, 1) var rotation_speed = 0.3
export (float, 0, 1) var rowing_strength = 0.15
export (float, 0, 0.5) var rowing_range = 0.25
export (float, 0, 0.5) var rowing_gap = 0.15
var rowing_add
var amount_rowed = 0
var side = 0

func get_input() -> void:
	if Input.is_action_pressed("row_left") and !Input.is_action_pressed("row_right"):
		side = 1
	if Input.is_action_pressed("row_right") and !Input.is_action_pressed("row_left"):
		side = 0
	if Input.is_action_pressed("row_right")	or Input.is_action_pressed("row_left"):
		amount_rowed += rowing_strength

func wave_oar() -> float:
	return sin(amount_rowed) * rowing_range

func _physics_process(delta: float) -> void:
	get_input()
	if side:
		rowing_add = rowing_gap
	else:
		rowing_add = -rowing_gap
	rotation = lerp_angle(rotation, side * PI + wave_oar() + rowing_add, rotation_speed)
