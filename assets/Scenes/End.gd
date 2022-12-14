extends Control

func survived(target: String) -> void:
	$AnimationPlayer.play("Fade")
	yield($AnimationPlayer,"animation_finished")
	SceneTransition.change_scene(target)
