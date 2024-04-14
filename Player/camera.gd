extends Camera2D

func shake(dir : Vector2) -> void:
	offset = dir * 5
	var tween  = create_tween()
	tween.tween_property(self, "offset", Vector2.ZERO, 0.1).set_ease(Tween.EASE_OUT)
