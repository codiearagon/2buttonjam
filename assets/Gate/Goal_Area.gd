extends Area2D

#var next_level = preload("res://assets/Scenes/Level_2.tscn")

func _on_Goal_Area_body_entered(body: Node) -> void:
	get_tree().change_scene("res://assets/Scenes/Level_2.tscn")
