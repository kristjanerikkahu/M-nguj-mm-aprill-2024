extends AnimationPlayer

@onready var player : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $".."

func _process(_delta):
	if player.velocity.x > 0:
		sprite.flip_h = true
	if player.velocity.x < 0:
		sprite.flip_h = false
	
	if player.dashing:
		play("dash")
		return
		
	if player.is_on_floor() and player.velocity.x != 0:
		play("walk")
	else:
		play("idle")
	
	if !player.is_on_floor():
		if player.velocity.y > 0:
			play("fall")
		else:
			play("jump")
