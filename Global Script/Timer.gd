extends RichTextLabel


func _process(delta):
	var time_in_sec = Gamemaster.timer_in_seconds
	var decimals = round((time_in_sec - floor(time_in_sec)) * 100)
	var seconds = time_in_sec%60
	var minutes = (time_in_sec/60)%60
	
	text = minutes + ":" + seconds + "." + decimals
