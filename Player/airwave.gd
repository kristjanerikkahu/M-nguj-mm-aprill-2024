extends Sprite2D

var speed : float = 1

func _process(delta):
	scale += speed * delta * Vector2.ONE
