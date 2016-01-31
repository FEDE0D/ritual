extends Node2D

export(Color) var bg_color = Color(1, 1, 1, 1)
var ended = false
var winner = null


var item_tomados = 0

func _ready():
	Globals.set("Map", self)
	get_tree().set_pause(false)
	
	print("SET POWERS ACCORDING TO:")
	print(Stats.points)

	Globals.get("Transition").fadeIn()
	VisualServer.set_default_clear_color(bg_color)
	winner = null
	
#	get_node("players/player1").item = true
#	game_over()
	set_process_input(true)

func game_over():
	if not ended:
		ended = true
		winner = null
		for p in get_node("players").get_children():
			if p.item:
				winner = p
				break
		
		if winner != null:
			print("WINNER: ", winner)
			Stats.player_win(winner)
			get_node("GUI").update_stats()
			get_node("Camera2D").zoom_in(winner)
			Globals.get("Transition").fadeOut()
		else:
			print("GAME OVER")
			Globals.get("Transition").fadeOutWhite()

#func win(player):
#	ended = true
#	get_tree().set_pause(true)
#
#	Stats.player_win(player)
#	get_node("Camera2D").zoom_in(player)
#	Globals.get("Transition").fadeOut()

func add_flecha(f):
	get_node("flechas").add_child(f)

func item_tomado():
	item_tomados +=1
	get_node("middle").turn_on_light(item_tomados)
	if item_tomados == 4:
		get_node("layers/TileMap").abrir()
		get_node("GUI").show_timer()
		get_node("SamplePlayer").play("timer")

func add_item(i):
	get_node("middle").add_child(i)
#	get_node("GUI").show_timer()
