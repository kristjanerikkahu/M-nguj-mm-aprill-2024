extends Node

func player_death():
	var timer = get_tree().create_timer(2)
	await timer.timeout
	get_tree().current_scene.get_node("SpawnPoint").resurrect_player()
