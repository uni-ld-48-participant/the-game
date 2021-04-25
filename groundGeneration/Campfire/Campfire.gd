extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var fire_time = 10

var localDelta = 0

# Called when the node enters the scene tree for the first time.
func _process(delta):
	localDelta += delta
	if localDelta > fire_time:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
