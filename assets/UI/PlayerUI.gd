extends Control

func _on_Boat_health_changed(value, max_value) -> void:
	var health_bar = $VBoxContainer/Health
	var health_label = $VBoxContainer/Health/Label
	var tween = $VBoxContainer/Health/OnHitTween
	var style_box = health_bar.get("custom_styles/fg")
	
	health_label.text = str(value) + "/" + str(max_value)
	health_bar.max_value = max_value
	health_bar.value = value
	
	var normal = Color8(106, 139, 139)
	var on_hit = Color8(189, 148, 148)
	if value != max_value:
		tween.interpolate_method(style_box, "set_bg_color", on_hit, normal, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	
	
func _on_Boat_obtained_key(value) -> void:
	var key_icon = $VBoxContainer/KeyIcon
	var tween = $VBoxContainer/KeyIcon/ObtainTween
	if value == false:
		key_icon.modulate = Color8(20, 20, 20)
	else:
		tween.interpolate_method(key_icon, "set_modulate", key_icon.modulate, Color8(255, 255, 255), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
