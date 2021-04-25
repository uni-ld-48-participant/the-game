extends Node2D

var map: GameTileMap

func _ready():
	map = get_parent().get_node("GameTileMap") as GameTileMap
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartArea_body_entered(body):
	map.get_tile(30, 30).temperature = 0
	pass # Replace with function body.
