
extends Node

var points = {}

func _ready():
	reset()

func player_win(player):
	var key = player.get_name()
	
	if not points.has(key):
		points[key] = 0
	
	points[key] += 1

func reset():
	points["player1"] = 0
	points["player2"] = 0
	points["player3"] = 0
	points["player4"] = 0