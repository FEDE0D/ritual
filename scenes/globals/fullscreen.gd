
extends Node

const VAL_THRESH = 0.5

func _ready():
	set_process_input(true)

func _input(event):
	if Input.is_action_pressed("fullscreen"):
		OS.set_window_fullscreen(not OS.is_window_fullscreen())
	if event.type == InputEvent.JOYSTICK_MOTION:
		if event.axis == 0:
			if event.value < -VAL_THRESH: # press LEFT
				if event.device == 0:
					Input.action_press("p3_left")
				elif event.device == 1:
					Input.action_press("p4_left")
			elif event.value > VAL_THRESH: # press RIGHT
				if event.device == 0:
					Input.action_press("p3_right")
				elif event.device == 1:
					Input.action_press("p4_right")
			elif event.value > -VAL_THRESH and event.value <= VAL_THRESH: # release LEFT & RIGHT
				if event.device == 0:
					Input.action_release("p3_left")
					Input.action_release("p3_right")
				elif event.device == 1:
					Input.action_release("p4_left")
					Input.action_release("p4_right")
		if event.axis == 1:
			if event.value < -VAL_THRESH: # press UP
				if event.device == 0:
					Input.action_press("p3_up")
				elif event.device == 1:
					Input.action_press("p4_up")
			elif event.value > VAL_THRESH: # press DOWN
				if event.device == 0:
					Input.action_press("p3_down")
				elif event.device == 1:
					Input.action_press("p4_down")
			elif event.value > -VAL_THRESH and event.value <= VAL_THRESH: # release UP & DOWN
				if event.device == 0:
					Input.action_release("p3_up")
					Input.action_release("p3_down")
				elif event.device == 1:
					Input.action_release("p4_up")
					Input.action_release("p4_down")
	
	print(event)
