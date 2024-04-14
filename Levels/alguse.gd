extends Node2D
var dialog=["Wise master: Young pupil... The time has come, your last task to complete your training and become a master weather summoner!","Wise master: You must travel to the THUNDER MOUNTAIN and acquire the blessing of the lighting gods.","Wise master: Are you ready for your last lesson?",""]
var ind=0


# Called when the node enters the scene tree for the first time.

func _ready():
	$AnimatedSprite2D2.visible=false
	$Sprite2D.visible=false
	$AnimatedSprite2D.play("default")
	$RichTextLabel.text=dialog[ind]
	#$RichTextLabel.add_font_override("normal_font", load(res://Fonts/04B_03__.TTF))
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("enter"):
		ind+=1
		updatetekst()
	if $AnimatedSprite2D2.frame==24:
		EzTransitions.set_easing(2, 2)
		EzTransitions.set_trans(10, 10)
		EzTransitions.set_timers(1.5, 0, 1.5)
		EzTransitions.set_reverse(false, true)
		EzTransitions.set_textures("res://addons/ez_transitions/images/black_texture.png", "res://addons/ez_transitions/images/black_texture.png")
		EzTransitions.set_types(1, 1)
		EzTransitions.change_scene("res://Levels/proov1.tscn") 


func _on_animated_sprite_2d_animation_finished():
	pass
	#$AnimatedSprite2D2.visible=true
	#$AnimatedSprite2D2.play("default")

	






func updatetekst():
	if ind>=4:
		pass
	elif ind==1:
		$AnimatedSprite2D.visible=false
		$Sprite2D.visible=true
		$RichTextLabel.text=dialog[ind]
	elif ind==2:
		$Sprite2D.visible=false
		$AnimatedSprite2D.visible=true
		$RichTextLabel.text=dialog[ind]
	elif ind==3:
		$AnimatedSprite2D.visible=false
		$AnimatedSprite2D2.visible=true
		$AnimatedSprite2D2.play("default")
		$Panel.visible=false
		$RichTextLabel.text=dialog[ind]
		
		


func _on_animated_sprite_2d_2_animation_finished():
	EzTransitions.set_easing(2, 2)
	EzTransitions.set_trans(10, 10)
	EzTransitions.set_timers(1, 0, 1)
	EzTransitions.set_reverse(false, true)
	EzTransitions.set_textures("res://addons/ez_transitions/images/black_texture.png", "res://addons/ez_transitions/images/black_texture.png")
	EzTransitions.set_types(1, 1)
	EzTransitions.change_scene("res://Levels/level3.tscn") # Replace with function body.
