extends Camera2D

func _shake(dir : Vector2):
	var os : Vector2 = -dir * 5
	create_tween()
	
