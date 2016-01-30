
extends Label

var time = 90
var text = ""

func _ready():
	set_process(true)

func _process(delta):
	time = max(time - delta, 0)
	text = str(int(time / 60.0)).pad_zeros(2) + ":" + str(int(fmod(time, 60))).pad_zeros(2)
	set_text(text)

