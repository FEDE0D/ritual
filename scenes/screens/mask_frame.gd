
extends TextureFrame

export(Texture) var mask_1 = preload("res://icon.png")
export(Texture) var mask_2 = preload("res://icon.png")
export(Texture) var mask_3 = preload("res://icon.png")
export(Texture) var mask_4 = preload("res://icon.png")

var index = 0

func _ready():
	update_mask()

func up():
	print("UP")
	index -= 1
	index %= 4
	update_mask()

func down():
	print("DOWN")
	index += 1
	index %= 4
	update_mask()

func update_mask():
	if index == 0:
		set_texture(mask_1)
	elif index == 1:
		set_texture(mask_2)
	elif index == 2:
		set_texture(mask_3)
	elif index == 3:
		set_texture(mask_4)

