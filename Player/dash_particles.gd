extends Node2D

var emitting = false

@onready var p1 : GPUParticles2D = $P1
@onready var p2 : GPUParticles2D  = $P2

func toggle_emission():
	emitting = !emitting
	
	p1.emitting = emitting
	p2.emitting = emitting
