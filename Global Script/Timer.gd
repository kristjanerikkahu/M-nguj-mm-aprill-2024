extends Label


func _process(delta):
	var time_in_sec = Gamemaster.timer_in_seconds
	var decimals = round((time_in_sec - floor(time_in_sec)) * 100)
	var seconds = int(floor(time_in_sec)) % 60
	var minutes = int(floor((time_in_sec / 60.0))) % 60
	
	if seconds < 10:
		seconds = str("0", seconds)
	if minutes < 10:
		minutes = str("0", minutes)
	if decimals < 10:
		decimals = str("0", decimals)
	
	text = str(minutes, ":", seconds, ".", decimals)
