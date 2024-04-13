extends Node2D

# TODO: Particle effects for landing on cloud

@onready var timer : Timer = $Timer

func _ready():
	timer.start()

# TODO: Proper destruction of cloud
func _on_timer_timeout():
	queue_free()
