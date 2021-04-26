extends Node2D

var map: GameTileMap

func _ready():
	map = get_parent().get_node("GameTileMap") as GameTileMap
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ColdTestArea_body_entered(body):
	if body.is_in_group("woompers") || body.is_in_group("stomper"):
		for q in range(0, 25):
			map.get_tile(2, q).temperature = 0
			map.get_tile(26, q).temperature = 0


func _on_StartArea_body_entered(body):
	if body.is_in_group("stomper"):
		remove_child($StartArea)
		for q in range(30, 55):
			map.get_tile(0, q).temperature = 0
			map.get_tile(29, q).temperature = 0
			
		for q in range(0,5):
			var scene = load("res://Woomper/Woomper.tscn")
			var woomper = scene.instance()
			woomper.position = Vector2(300 + 150 * q, 800 - 20*q)
			get_parent().add_child(woomper)
