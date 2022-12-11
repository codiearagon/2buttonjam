extends StaticBody2D

signal gate_unlocked

var gate_unlocked: bool = false
	
func set_unlocked(value: bool):
	gate_unlocked = value
	emit_signal("gate_unlocked")
