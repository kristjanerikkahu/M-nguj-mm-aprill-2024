extends Area2D

@export var error_margin : int = 100
@export var accuracy : float = 0.2

@onready var player : CharacterBody2D = $".."
@onready var player_col : CollisionShape2D = $"../Collider"
@onready var col : CollisionShape2D = $CollisionShape2D

# TODO: Add horizontal error checking
func _physics_process(delta):
	if player.is_on_ceiling():
		print("Checking")
		var col_extents : Vector2 = col.shape.get_rect().size
		
		var start_pos = col_extents.x / 2
		var top = col_extents.y / 2
		
		var ray : RayCast2D = RayCast2D.new()
		ray.collide_with_bodies = true
		ray.collide_with_areas = false
		ray.position = player.global_position
		ray.position = Vector2(start_pos, -top + 5) 
		ray.target_position.y = -100
		player.add_child(ray)
		
		var margin = 0
		var error_within_margin : bool = false
		
		if ray.is_colliding():
			print("col")
			while (margin >= -error_margin):
				print("Margin from right")
				ray.position.x -= accuracy
				margin -= accuracy
				if not ray.is_colliding():
					error_within_margin = true
					break
		else:
			ray.position.x = -start_pos
			if ray.is_colliding():
				print("Margin from left")
				while (margin <= error_margin):
					ray.position.x += accuracy
					margin += accuracy
					if not ray.is_colliding():
						error_within_margin = true
						break
						
		if error_within_margin:
			player.position.x -= margin
