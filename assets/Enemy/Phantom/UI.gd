extends Control

func _on_Phantom_health_changed(value) -> void:
	$Health/Label.text = "HP: " + str(value)
