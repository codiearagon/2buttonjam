extends Control

func _on_Boat_health_changed(value) -> void:
	$HBoxContainer/Health/Label.text = "HP: " + str(value)

func _on_Boat_obtained_key(value) -> void:
	$HBoxContainer/Key/Label.text = "Key: " + str(value)
