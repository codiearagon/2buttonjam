extends StaticBody2D

var opened_door = preload("res://assets/Gate/gate_open.png")
var gate_unlocked: bool = false
	
func set_unlocked(value: bool):
	var door_sprite = $DoorSprite
	
	gate_unlocked = value
	door_sprite.texture = opened_door
	$Door.disabled = true
