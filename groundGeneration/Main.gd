extends Node

func _ready():
	if OS.has_touchscreen_ui_hint():
		show_mobile_controls(true)
	else:
		show_mobile_controls(false)

func _input(ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		_pause()

func _pause():
	if get_tree().paused:
		$"Menu/Control-Menu".hide()
		$"Menu/background".hide()
		$"Menu/Button-Restart".hide()
		get_tree().paused = false
	else:
		$"Menu/Control-Menu".show()
		$"Menu/background".show()
		$"Menu/Button-Restart".show()
		get_tree().paused = true


func _on_ButtonPause_pressed():
	_pause()


func _on_ButtonRestart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
	
func show_mobile_controls(isShow: bool):
	if isShow:
		$Menu/MobileControls.show()
	else:
		$Menu/MobileControls.hide()
	
func simulate_key(action, is_pressed):
	if is_pressed:
		Input.action_press(action)
	else:
		Input.action_release(action)

func _on_UpButton_button_down():
	simulate_key("ui_up", true)

func _on_UpButton_button_up():
	simulate_key("ui_up", false)


func _on_DownButton_button_down():
	simulate_key("ui_down", true)


func _on_DownButton_button_up():
	simulate_key("ui_down", false)


func _on_LeftButton_button_down():
	simulate_key("ui_left", true)


func _on_LeftButton_button_up():
	simulate_key("ui_left", false)


func _on_RightButton_button_down():
	simulate_key("ui_right", true)


func _on_RightButton_button_up():
	simulate_key("ui_right", false)


func _on_MushroomButton_pressed():
	simulate_key("ui_mushroom", true)


func _on_CampfireButton_pressed():
	simulate_key("ui_campfire", true)
