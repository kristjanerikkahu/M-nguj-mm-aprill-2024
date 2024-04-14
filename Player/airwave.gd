extends Sprite2D

var speed : float = 3

func _process(delta):
	scale += speed * delta * Vector2.ONE


func _on_gpu_particles_2d_finished():
	owner.queue_free()
