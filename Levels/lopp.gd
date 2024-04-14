extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	BgMusic.stop()
	$Sprite2D2.visible=false
	await get_tree().create_timer(4).timeout
	$Sprite2D2.visible=true
	$Sprite2D.visible=false
	await get_tree().create_timer(4).timeout
	var tween = $Sprite2D2.create_tween()
	var mod_intensity = 160 / 255
	tween.tween_property($Sprite2D2, "modulate:r", mod_intensity, 2)
	tween.parallel().tween_property($Sprite2D2, "modulate:g", mod_intensity, 2)
	tween.parallel().tween_property($Sprite2D2, "modulate:b", mod_intensity, 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
