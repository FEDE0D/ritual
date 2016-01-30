
extends Label

var time = 30
var text = ""

func start_timer():
	time = 30
	set_process(true)

func _process(delta):
	time = max(time - delta, 0)
	text = str(int(time / 60.0)).pad_zeros(2) + ":" + str(int(fmod(time, 60))).pad_zeros(2)
	set_text(text)
	
	if time <= 0.0:
		Globals.get("Map").game_over()

