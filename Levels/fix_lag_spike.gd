extends CanvasLayer

var FirstParticlesMaterial = preload("res://Shaders/airwave.gdshader")
var SecondParticlesMaterial = preload("res://Shaders/shockwave.gdshader")

var materials = [
	FirstParticlesMaterial,
	SecondParticlesMaterial,
]

func _ready():
	for material in materials:
		var particles_instance = CPUParticles2D.new()
		particles_instance.material = material
		particles_instance.set_one_shot(true)
		particles_instance.set_emitting(true)
		self.add_child(particles_instance)
