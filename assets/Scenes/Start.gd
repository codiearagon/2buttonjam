extends Control

func start() -> void:
	$AnimationPlayer.play("Fade")
	yield($AnimationPlayer,"animation_finished")
