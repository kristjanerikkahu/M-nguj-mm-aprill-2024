extends Node2D

@onready var sprite : AnimatedSprite2D = $"../Sprite"
var flipped : bool = false
@onready var spawnpos : Marker2D = $WalkingParticles

func _process(delta):
	if sprite.flip_h != flipped:
		spawnpos.position.x = -6 if flipped else -10
		flipped = sprite.flip_h
	
	print(spawnpos.global_position - owner.global_position)
