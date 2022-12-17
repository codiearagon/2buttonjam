extends Area2D

func _on_Range_body_entered(body: Node) -> void:
	var attack_rate = get_node("../Attack_Rate")
	if attack_rate.is_stopped() && body.get_collision_layer_bit(2):
		attack_rate.start()


var has_enemy: bool
func _process(delta: float) -> void:
	var has_enemy = false
	var attack_rate = get_node("../Attack_Rate")
	for body in get_overlapping_bodies():
		if body.get_collision_layer_bit(2):
			has_enemy = true
	
	if !has_enemy:
		if !attack_rate.is_stopped():
				attack_rate.stop()
	
	
