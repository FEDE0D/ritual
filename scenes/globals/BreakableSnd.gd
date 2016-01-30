
extends SamplePlayer

func play_sound():
	var r = randi() % 7
	if r == 0:
		play("Madera_1")
	elif r == 1:
		play("Madera_2")
	elif r == 2:
		play("Madera_3")
	elif r == 3:
		play("Madera_4")
	elif r == 4:
		play("Madera_5")
	elif r == 5:
		play("Madera_6")
	elif r == 6:
		play("Madera_7")

func play_sound_item():
	play("pickup")