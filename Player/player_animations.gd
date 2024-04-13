extends AnimationPlayer

@onready var player : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $".."

# TODO: Falling animation
func _process(delta):
	if player.velocity.x > 0:
		sprite.flip_h = true
	if player.velocity.x < 0:
		sprite.flip_h = false
	
	if player.is_on_floor() and player.velocity.x != 0:
		play("walk")
	else:
		play("idle")
	
	if !player.is_on_floor():
		if player.dashing:
			play("dash")
		else:
			play("jump")
