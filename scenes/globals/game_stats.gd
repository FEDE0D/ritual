
extends Node

var points = {}

func _ready():
	points["player1"] = 0
	points["player2"] = 0
	points["player3"] = 0
	points["player4"] = 0

func player_win(player):
	var key = player.get_name()
	
	if not points.has(key):
		points[key] = 0
	
	points[key] += 1

