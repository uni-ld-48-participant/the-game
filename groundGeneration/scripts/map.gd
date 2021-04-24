extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	# generate map here
	$TileMap.set_cell(1, 1, 1)
	$TileMap.set_cell(0, 0, 2)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
