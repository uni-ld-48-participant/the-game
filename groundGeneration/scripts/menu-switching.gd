extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"Control-Menu".show()
	$"Control-Menu/Control-Main".show()
	$"Control-Menu/Control-About".hide()
	$"Button-Pause".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonAbout_pressed():
	$"Control-Menu/Control-About".show()
	$"Control-Menu/Control-Main".hide()


func _on_ButtonClose_pressed():
	$"Control-Menu/Control-About".hide()
	$"Control-Menu/Control-Main".show()


func _on_ButtonPause_pressed():
	$"Control-Menu".show()
	$"Button-Pause".hide()


func _on_ButtonStart_pressed():
	$"Control-Menu".hide()
	$"Button-Pause".show()
