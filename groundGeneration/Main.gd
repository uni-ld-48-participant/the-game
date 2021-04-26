extends Node


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
