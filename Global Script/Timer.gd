extends Label


func _process(delta):
	var time_in_sec = Gamemaster.timer_in_seconds
	var decimals = round((time_in_sec - floor(time_in_sec)) * 100)
	var seconds = int(floor(time_in_sec)) % 60
	var minutes = int(floor((time_in_sec / 60.0))) % 60
	
	text = str(minutes, ":", seconds, ".", decimals)
