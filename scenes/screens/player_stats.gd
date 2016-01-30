
extends TextureFrame

export(int) var player_index = 0

func _ready():
	update_stats()
	
func update_stats():
	get_node("Label").set_text("P"+str(player_index+1))
	var points = Stats.points[Stats.points.keys()[player_index]]
	
	if points >= 1:
		get_node("i1").set_texture(preload("res://graphics/btn_1.png"))
	if points >= 2:
		get_node("i2").set_texture(preload("res://graphics/btn_2.png"))
	if points >= 3:
		get_node("i3").set_texture(preload("res://graphics/btn_3.png"))
