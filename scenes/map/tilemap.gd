
extends TileMap
onready var blocks = get_node("../blocks")

var breakables = []

func _ready():
	var c = 0
	for x in range(0, 20):
		for y in range(0, 20):
			c = get_cell(x, y)
			if c == 2:
				set_cell(x, y, -1)
				var s = preload("res://scenes/map/blocks/breakable.scn").instance()
				blocks.add_child(s)
				breakables.append(s)
				s.set_pos(Vector2(x*32 + 16, y*32 + 16))
			elif c == 3:
				set_cell(x, y, -1)
				var s = preload("res://scenes/map/blocks/hole.scn").instance()
				blocks.add_child(s)
				s.set_pos(Vector2(x*32 + 16, y*32 + 16))
	
	# Agregar los 4 items al azar en los breakables
	for c in range(0, 4):
		var i = randi()%breakables.size()
		breakables[i].drops_item = true
		breakables.remove(i)

func abrir():
	for x in range(7, 12):
		for y in range(7, 12):
			set_cell(x, y, -1)

