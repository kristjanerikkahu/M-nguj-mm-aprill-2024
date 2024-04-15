extends CanvasLayer

var cloud : PackedScene = preload("res://Powers/Cloud.tscn")
var death_particles : PackedScene = preload("res://Player/death_particles.tscn")
var _dash_followup : PackedScene = preload("res://Player/dash_follow_up.tscn")
var _landing_particles : PackedScene = preload("res://Player/landing_particles.tscn")
var _walking_particles : PackedScene = preload("res://Player/walking_particles.tscn")
var _spawn_point_particles : PackedScene = preload("res://Global Script/res_particles.tscn")

var preload_lag_spikers : Array[PackedScene] = [
	cloud,
	death_particles,
	_dash_followup,
	_landing_particles,
	_walking_particles,
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for lag_spiker : PackedScene in preload_lag_spikers:
		print(lag_spiker.resource_path)
		
		var spiker = lag_spiker.instantiate()
		spiker.position = Vector2(-10_000, -10_000)
		add_child(spiker)
		
	_spawn_point_particles.instantiate().emitting = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
