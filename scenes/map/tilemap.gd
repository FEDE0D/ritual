
extends TileMap
onready var blocks = get_node("../blocks")

func _ready():
	var c = 0
	for x in range(0, 20):
		for y in range(0, 20):
			c = get_cell(x, y)
			if c == 2:
				set_cell(x, y, -1)
				var s = preload("res://scenes/map/blocks/breakable.scn").instance()
				blocks.add_child(s)
				s.set_pos(Vector2(x*32 + 16, y*32 + 16))
			elif c == 3:
				set_cell(x, y, -1)
				var s = preload("res://scenes/map/blocks/hole.scn").instance()
				blocks.add_child(s)
				s.set_pos(Vector2(x*32 + 16, y*32 + 16))


