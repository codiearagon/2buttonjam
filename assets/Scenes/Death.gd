extends Node2D

func _ready():
	$Timer.wait_time = 5
	$Timer.start()
	
func _process(delta: float) -> void:
	$GUI/Respawn_Text.text = "Respawning in " + str(floor($Timer.time_left)) + "..."


func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://assets/Scenes/Level.tscn")
