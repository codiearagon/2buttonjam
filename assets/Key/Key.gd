extends Area2D

	
func _on_Key_body_entered(body: Node) -> void:
	if body.name == "Boat":
		body.obtained_key = true
		queue_free()
