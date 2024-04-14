extends Sprite2D

var dir : Vector2 = Vector2.ZERO
var speed = 1000

func _process(delta):
	rotation = dir.angle() - PI/2
	position += Vector2.from_angle(dir.angle() - PI) * speed * delta
	scale += 1 * delta * Vector2.ONE


func _on_timer_timeout():
	queue_free()
