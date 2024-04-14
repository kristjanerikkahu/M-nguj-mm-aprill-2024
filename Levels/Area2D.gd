extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_body_entered(body):
	EzTransitions.set_easing(0, 1)
	EzTransitions.set_trans(10, 10)
	EzTransitions.set_timers(0.5, 0, 0.5)
	EzTransitions.set_reverse(false, true)
	EzTransitions.set_textures("res://addons/ez_transitions/images/black_texture.png", "res://addons/ez_transitions/images/black_texture.png")
	EzTransitions.set_types(1, 1)
	EzTransitions.change_scene("res://Levels/level2.tscn")
