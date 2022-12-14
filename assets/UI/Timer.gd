extends Node2D

export var max_seconds: int = 120

func _ready():
	$Survive_Timer.wait_time = max_seconds
	$Survive_Timer.start()
	
func _process(delta: float) -> void:
	var minutes = floor($Survive_Timer.time_left / 60)
	var seconds = floor($Survive_Timer.time_left / (minutes + 1))
	
	$GUI/Timer/Panel/Label.text = str(minutes) + ":" + str(seconds)

func _on_Survive_Timer_timeout() -> void:
	pass # Replace with function body.
