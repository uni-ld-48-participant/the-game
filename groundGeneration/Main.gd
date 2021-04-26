extends Node


func _input(ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		_pause()

func _pause():
	if get_tree().paused:
		$"Menu/Control-Menu".hide()
		$"Menu/background".hide()
		get_tree().paused = false
	else:
		$"Menu/Control-Menu".show()
		$"Menu/background".show()
		get_tree().paused = true


func _on_ButtonPause_pressed():
	_pause()
