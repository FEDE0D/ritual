
extends Node2D

var powers = [0, 1, 2]

func _ready():
	randomize()
	for i in range(0, 3):
		var r = powers[randi() % powers.size()]
		powers.erase(r)
		if r == 0:
			get_child(i).p_push = true
		elif r == 1:
			get_child(i).p_slow = true
		elif r == 2:
			get_child(i).p_god = true
		get_child(i).post_ready()
#		print(get_child(i).get_name(), " ", r)