extends Node2D

var sun_cd:=false
var wind_cd:=false
var cloud_cd:=false

var sun=preload("res://Powerid/Sun.tscn")	
var wind=preload("res://Powerid/wind.tscn")
var cloud=preload("res://Powerid/Cloud.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		if Input.is_action_pressed("PÄIKE"):
			if !sun_cd:
				summon_paike()
				sun_cd=true
				await get_tree().create_timer(10).timeout
				sun_cd=false
		if Input.is_action_pressed("TUUL"):
			if !wind_cd:
				summon_tuul()
				wind_cd=true
				await get_tree().create_timer(10).timeout
				wind_cd=false
		if Input.is_action_pressed("PILV"):
			if !cloud_cd:
				summon_pilv()
				cloud_cd=true
				await get_tree().create_timer(10).timeout
				cloud_cd=false		

		
func summon_paike():
	var sun1=sun.instantiate()
	sun1.position=$Player/CharacterBody2D.position+Vector2(0,-50)
	add_child(sun1)
	
func summon_tuul():
	var wind1=wind.instantiate()
	wind1.position=$Player/CharacterBody2D.position+Vector2(0,-50)
	add_child(wind1)
	
func summon_pilv():
	var pilv1=cloud.instantiate()
	pilv1.position=$Player/CharacterBody2D.position+Vector2(0,-50)
	add_child(pilv1)

	
	
