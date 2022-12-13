extends StaticBody2D

var gate_unlocked: bool = false
	
func set_unlocked(value: bool):
	gate_unlocked = value
	get_node("DoorSprite").texture = load("res://assets/Gate/gate_open.png")
	get_node("Door").disabled = true
