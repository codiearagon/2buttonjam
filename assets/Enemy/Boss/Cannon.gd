extends Sprite

func _physics_process(delta: float) -> void:
	look_at(get_node("../../Boat/Center").global_position)
