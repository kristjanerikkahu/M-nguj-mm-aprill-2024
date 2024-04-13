extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = $"../CharacterBody2D".position
	
	text = str(pos.x) + " " + str(pos.y)
