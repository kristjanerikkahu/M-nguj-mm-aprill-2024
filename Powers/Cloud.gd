extends Node2D

# TODO: Proper creation of cloud
# TODO: Particle effects for landing on cloud
# TODO: Pull clouds? naaaah

@onready var timer : Timer = $Timer

func _on_area_2d_body_entered(body : Player):
	if body:
		timer.start()

# TODO: Proper destruction of cloud
func _on_timer_timeout():
	queue_free()
