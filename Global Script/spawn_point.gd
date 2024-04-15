extends Marker2D

var player : PackedScene = preload("res://Player/player.tscn")

func resurrect_player():
	RespawnSound.play()
	$Particles.emitting = true
	await get_tree().create_timer(0.8).timeout
	var p = player.instantiate()
	p.position = global_position
	get_tree().current_scene.add_child(p)
	
	Gamemaster.timing = true
