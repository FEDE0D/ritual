
extends TextureFrame

export(int) var player_index = 0

func _ready():
	get_node("Label").set_text("P"+str(player_index+1))


