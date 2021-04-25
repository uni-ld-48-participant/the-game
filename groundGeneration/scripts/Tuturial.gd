extends Node2D

var map: GameTileMap

func _ready():
	map = get_parent().get_node("GameTileMap") as GameTileMap
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ColdTestArea_body_entered(body):
	if body.is_in_group("woompers"):
		map.get_tile(8, 9).temperature = 0
		map.get_tile(8, 10).temperature = 0
		map.get_tile(8, 11).temperature = 0
		map.get_tile(8, 12).temperature = 0
		map.get_tile(20, 9).temperature = 0
		map.get_tile(20, 10).temperature = 0
		map.get_tile(20, 11).temperature = 0
		map.get_tile(20, 12).temperature = 0
	pass # Replace with function body.
