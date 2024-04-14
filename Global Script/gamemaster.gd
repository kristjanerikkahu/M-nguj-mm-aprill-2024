extends Node

var timer_in_seconds : float = 0
var timing : bool = false

func _process(delta):
	if timing:
		timer_in_seconds += delta

func player_death():
	timing = false
	var timer = get_tree().create_timer(2)
	await timer.timeout
	get_tree().current_scene.get_node("SpawnPoint").resurrect_player()
