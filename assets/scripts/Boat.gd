extends KinematicBody2D

export (int) var speed = 200
export (float) var rotation_speed = 1.5

var velocity = Vector2.ZERO
var rotation_dir = 0

func get_input() -> void:
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("row_left"):
		rotation_dir += 1
		velocity = Vector2(-speed, 1).rotated(rotation)
	if Input.is_action_pressed("row_right"):
		rotation_dir -= 1
		velocity = Vector2(speed, 1).rotated(rotation)

func _physics_process(delta: float) -> void:
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
