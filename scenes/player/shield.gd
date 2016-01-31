
extends RigidBody2D


const TIMER = 1.0
var time = 0.0

func _ready():
	set_process(true)

func _process(delta):
	time += delta
	if time > TIMER:
		queue_free()


