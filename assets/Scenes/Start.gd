extends Control

func _ready() -> void:
	$AnimationPlayer.play("Fade")
	yield($AnimationPlayer,"animation_finished")
