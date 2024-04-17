extends Node2D

@onready var sprite : AnimatedSprite2D = owner.get_node("Sprite")
var flipped : bool = false

func _process(delta):
	if sprite.flip_h != flipped:
		position.x = -6 if flipped else -10
		flipped = sprite.flip_h
