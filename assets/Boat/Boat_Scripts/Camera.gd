extends Camera2D

func _process(delta: float) -> void:
	position = get_node("../Boat/Center").global_position
