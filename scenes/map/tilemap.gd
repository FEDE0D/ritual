
extends TileMap
onready var blocks = get_node("../blocks")

const RATIO_TRAPS = 0.1
const RATIO_BREAKABLES = 0.5

var breakables = []

func _ready():
	var c = 0
	for x in range(0, 20):
		for y in range(0, 20):
			if x >= 0 and x <= 3:
				if y >= 0 and y <= 3:
					continue
				if y >= 16 and y <= 20:
					continue
			if x >= 16 and x <= 20:
				if y >= 0 and y <= 3:
					continue
				if y >= 16 and y <= 20:
					continue
			if x >= 8 and x <= 11:
				if y>=8  and y <= 11:
					continue
			c = get_cell(x, y)
			if c == -1 and rand_range(0, 1) < RATIO_TRAPS:
				var s = preload("res://scenes/map/blocks/hole.scn").instance()
				blocks.add_child(s)
				s.set_pos(Vector2(x*32 + 16, y*32 + 16))
			if c == -1 and rand_range(0, 1) < RATIO_BREAKABLES:
				var s = preload("res://scenes/map/blocks/breakable.scn").instance()
				blocks.add_child(s)
				breakables.append(s)
				s.set_pos(Vector2(x*32 + 16, y*32 + 16))
	
	# Agregar los 4 items al azar en los breakables
	for c in range(0, 4):
		var i = randi()%breakables.size()
		breakables[i].drops_item = true
		breakables.remove(i)
	
	# Agregar 

func abrir():
	for x in range(7, 12):
		for y in range(7, 12):
			set_cell(x, y, -1)

