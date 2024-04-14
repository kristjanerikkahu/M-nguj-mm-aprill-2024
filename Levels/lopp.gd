extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D2.visible=false
	await get_tree().create_timer(4).timeout
	$Sprite2D2.visible=true
	$Sprite2D.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
